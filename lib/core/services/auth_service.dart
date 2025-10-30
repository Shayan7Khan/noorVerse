import 'package:flutter_antonx_boilerplate/core/models/body/login_body.dart';
import 'package:flutter_antonx_boilerplate/core/models/body/reset_password_body.dart';
import 'package:flutter_antonx_boilerplate/core/models/body/signup_body.dart';
import 'package:flutter_antonx_boilerplate/core/models/other_models/user_profile.dart';
import 'package:flutter_antonx_boilerplate/core/models/responses/auth_response.dart';
import 'package:flutter_antonx_boilerplate/core/models/responses/user_profile_response.dart';
import 'package:flutter_antonx_boilerplate/core/models/user.dart';
import 'package:flutter_antonx_boilerplate/core/others/logger_customizations/custom_logger.dart';
import 'package:flutter_antonx_boilerplate/core/services/database_service.dart';
import 'package:flutter_antonx_boilerplate/core/services/mock_database_service.dart';
import 'package:flutter_antonx_boilerplate/core/services/device_info_service.dart';
import 'package:flutter_antonx_boilerplate/core/services/local_storage_service.dart';
import 'package:flutter_antonx_boilerplate/core/services/notifications_service.dart';
import 'package:flutter_antonx_boilerplate/locator.dart';
import 'package:flutter_antonx_boilerplate/ui/custom_widgets/dialogs/auth_dialog.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'dart:convert';

///
/// [AuthService] class contains all authentication related logic with following
/// methods:
///
/// [doSetup]: This method contains all the initial authentication like checking
/// login status, onboarding status and other related initial app flow setup.
///
/// [signupWithEmailAndPassword]: This method is used for signup with email and password.
///
/// [signupWithApple]:
///
/// [signupWithGmail]:
///
/// [signupWithFacebook]:
///
/// [logout]:
///

class AuthService {
  late bool isLogin;
  final _localStorageService = locator<LocalStorageService>();
  final _dbService = locator<DatabaseService>();
  final _mockDbService = locator<MockDatabaseService>();
  UserProfile? userProfile;
  User? currentUser;
  String? fcmToken;
  static final Logger log = CustomLogger(className: 'AuthService');

  ///
  /// [doSetup] Function does the following things:
  ///   1) Checks if the user is logged then:
  ///       a) Get the user profile data
  ///       b) Updates the user FCM Token
  ///
  doSetup() async {
    isLogin =
        _localStorageService.isLoggedIn &&
        _localStorageService.accessToken != null;
    if (isLogin) {
      log.d('User is already logged-in');
      await _loadUserFromStorage();
      await _getUserProfile();
      await _updateFcmToken();
    } else {
      log.d('@doSetup: User is not logged-in');
    }
  }

  _loadUserFromStorage() async {
    final userDataString = _localStorageService.userData;
    if (userDataString != null) {
      try {
        final userData = jsonDecode(userDataString);
        currentUser = User.fromJson(userData);
        log.d('Loaded user from storage: ${currentUser?.email}');
      } catch (e) {
        log.e('Error loading user from storage: $e');
      }
    }
  }

  _getUserProfile() async {
    UserProfileResponse response = await _dbService.getUserProfile();
    if (response.success) {
      userProfile = response.profile;
      log.d('Got User Data: ${userProfile?.toJson()}');
    } else {
      Get.dialog(AuthDialog(title: 'Title', message: response.error!));
    }
  }

  ///
  /// Updating FCM Token here...
  ///
  _updateFcmToken() async {
    try {
      final fcmToken = await locator<NotificationsService>().getFcmToken();
      final deviceId = await DeviceInfoService().getDeviceId();
      final response = await _mockDbService.updateFcmToken(deviceId, fcmToken!);
      if (response) {
        userProfile?.fcmToken = fcmToken;
      }
    } catch (e) {
      log.e('Error updating FCM token: $e');
    }
  }

  signupWithEmailAndPassword(SignUpBody body) async {
    late AuthResponse response;
    // Use mock service for demo
    response = await _mockDbService.createAccount(body);
    if (response.success) {
      // Create user object from signup data
      currentUser = User(
        email: body.email,
        name: body.name,
        phone: body.phone,
        createdAt: DateTime.now(),
      );

      // Save user data to local storage
      _localStorageService.userData = jsonEncode(currentUser!.toJson());
      _localStorageService.accessToken = response.accessToken;
      _localStorageService.isLoggedIn = true;
      isLogin = true;

      userProfile = UserProfile.fromJson(body.toJson());
      await _updateFcmToken();

      log.d('User signed up successfully: ${currentUser?.email}');
    }
    return response;
  }

  loginWithEmailAndPassword(LoginBody body) async {
    late AuthResponse response;
    // Use mock service for demo
    response = await _mockDbService.loginWithEmailAndPassword(body);
    if (response.success) {
      // Load user data from mock service
      final userData = await _mockDbService.getUserProfile();
      currentUser = User.fromJson(userData);

      _localStorageService.userData = jsonEncode(currentUser!.toJson());
      _localStorageService.accessToken = response.accessToken;
      _localStorageService.isLoggedIn = true;
      isLogin = true;

      await _updateFcmToken();

      log.d('User logged in successfully: ${body.email}');
    }
    return response;
  }

  resetPassword(ResetPasswordBody body) async {
    final AuthResponse response = await _mockDbService.resetPassword(body);
    if (response.success) {
      _localStorageService.accessToken = response.accessToken;
    }
    return response;
  }

  signupWithApple() {}

  signupWithGmail() {}

  signupWithFacebook() {}

  logout() async {
    isLogin = false;
    userProfile = null;
    currentUser = null;

    try {
      // Clear FCM token from server
      final deviceId = await DeviceInfoService().getDeviceId();
      await _mockDbService.clearFcmToken(deviceId);
    } catch (e) {
      log.e('Error clearing FCM token: $e');
    }

    // Clear all local storage
    _localStorageService.clearUserData();

    log.d('User logged out successfully');
  }
}
