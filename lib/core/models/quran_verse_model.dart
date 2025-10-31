class QuranVerse {
  final String title;
  final String arabicText;
  final String englishTranslation;
  final String surahName;
  final int verseNumber;

  QuranVerse({
    required this.title,
    required this.arabicText,
    required this.englishTranslation,
    required this.surahName,
    required this.verseNumber,
  });

  factory QuranVerse.fromApi({
    required Map<String, dynamic> arabicData,
    required Map<String, dynamic> englishData,
  }) {
    
    return QuranVerse(
      title: (arabicData['surah']?['englishName'] as String?) ?? 'Quran Verse',
      arabicText: (arabicData['text'] as String?) ?? '',
      englishTranslation: (englishData['text'] as String?) ?? '',
      surahName: (arabicData['surah']?['englishName'] as String?) ?? '',
      verseNumber: (arabicData['numberInSurah'] as int?) ?? (arabicData['number'] as int? ?? 0),
    );
  }
}


