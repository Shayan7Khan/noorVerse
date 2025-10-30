class Hadith {
  final String title;
  final String arabicText;
  final String englishTranslation;
  final String reference;
  final String bookName;
  final String? narrator;

  Hadith({
    required this.title,
    required this.arabicText,
    required this.englishTranslation,
    required this.reference,
    required this.bookName,
    this.narrator,
  });
}
