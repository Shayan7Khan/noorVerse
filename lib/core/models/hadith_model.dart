class Hadith {
  final String title;
  final String arabic;
  final String english;
  final String urdu;
  final String narrator;
  final String bookName;
  final String reference;

  Hadith({
    required this.title,
    required this.arabic,
    required this.english,
    required this.urdu,
    required this.narrator,
    required this.bookName,
    required this.reference,
  });

  factory Hadith.fromApi(Map<String, dynamic> json) {
    return Hadith(
      title: json["englishNarrator"] ?? "",
      arabic: json["hadithArabic"] ?? "",
      english: json["hadithEnglish"] ?? "",
      urdu: json["hadithUrdu"] ?? "",
      narrator: json["englishNarrator"] ?? "",
      bookName: "", 
      reference: json["hadithNumber"] ?? "",
    );
  }

}
