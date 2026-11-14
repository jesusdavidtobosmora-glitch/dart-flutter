import 'dart:io';

String? readText(String prompt) {
  while (true) {
    stdout.write(prompt);
    final input = stdin.readLineSync();
    if (input == null) return null;
    final value = input.trim();
    if (value.isNotEmpty) return value;
    print('This field cannot be empty.');
  }
}

int? readYear(String prompt) {
  while (true) {
    stdout.write(prompt);
    final input = stdin.readLineSync();
    if (input == null) return null;
    final value = int.tryParse(input.trim());
    if (value != null && value >= 0 && value <= 2100) return value;
    print('Enter a valid year from 0 to 2100.');
  }
}

String normalize(String value) => value.trim().toLowerCase();

void registerBook(Map<String, Map<String, String>> books) {
  final codeInput = readText('Book code: ');
  if (codeInput == null) return;
  final code = normalize(codeInput);

  if (books.containsKey(code)) {
    print('That code is already registered. No data was changed.');
    return;
  }

  final title = readText('Title: ');
  if (title == null) return;

  final genreInput = readText('Genre: ');
  if (genreInput == null) return;
  final genre = normalize(genreInput);

  final year = readYear('Publication year: ');
  if (year == null) return;

  books[code] = <String, String>{
    'title': title.trim(),
    'genre': genre,
    'year': year.toString(),
  };
  print('Book registered.');
}

void listBooks(Map<String, Map<String, String>> books) {
  if (books.isEmpty) {
    print('The library catalog is empty.');
    return;
  }

  final codes = books.keys.toList()..sort();
  print('\n=== BOOKS ===');
  for (final code in codes) {
    final book = books[code]!;
    print('$code | ${book['title']} | ${book['genre']} | ${book['year']}');
  }
}

void findBook(Map<String, Map<String, String>> books) {
  final codeInput = readText('Code to search: ');
  if (codeInput == null) return;

  final code = normalize(codeInput);
  final book = books[code];

  if (book == null) {
    print('Book not found.');
    return;
  }

  print('Code: $code');
  print('Title: ${book['title']}');
  print('Genre: ${book['genre']}');
  print('Year: ${book['year']}');
}

Set<String> getUniqueGenres(Map<String, Map<String, String>> books) {
  final genres = <String>{};
  for (final book in books.values) {
    final genre = book['genre'];
    if (genre != null) genres.add(normalize(genre));
  }
  return genres;
}

Map<String, int> countBooksByGenre(
  Map<String, Map<String, String>> books,
) {
  final counts = <String, int>{};

  for (final book in books.values) {
    final genre = book['genre'];
    if (genre == null) continue;
    final normalizedGenre = normalize(genre);
    counts[normalizedGenre] = (counts[normalizedGenre] ?? 0) + 1;
  }

  return counts;
}

void showGenres(Map<String, Map<String, String>> books) {
  if (books.isEmpty) {
    print('No genres available because the catalog is empty.');
    return;
  }

  final genres = getUniqueGenres(books).toList()..sort();
  final counts = countBooksByGenre(books);

  print('\n=== UNIQUE GENRES ===');
  for (final genre in genres) {
    print('$genre: ${counts[genre] ?? 0} book(s)');
  }
}

void showBooksByGenre(Map<String, Map<String, String>> books) {
  final genreInput = readText('Genre to consult: ');
  if (genreInput == null) return;
  final genre = normalize(genreInput);

  final titles = <String>[];
  for (final book in books.values) {
    if (normalize(book['genre'] ?? '') == genre) {
      titles.add(book['title'] ?? '');
    }
  }

  if (titles.isEmpty) {
    print('No books found for genre "$genre".');
    return;
  }

  titles.sort();
  print('Books in "$genre":');
  for (final title in titles) {
    print(title);
  }
}

void main() {
  // code -> book fields. Data remains in memory during this session.
  final books = <String, Map<String, String>>{};

  while (true) {
    print('\n=== COMMUNITY LIBRARY ===');
    print('1. Register book');
    print('2. List books');
    print('3. Find book by code');
    print('4. Show unique genres and counts');
    print('5. List books by genre');
    print('0. Exit');

    stdout.write('Option: ');
    final input = stdin.readLineSync();
    if (input == null) {
      print('Goodbye!');
      return;
    }

    final option = int.tryParse(input.trim());
    if (option == null || option < 0 || option > 5) {
      print('Choose an option from 0 to 5.');
      continue;
    }

    switch (option) {
      case 1:
        registerBook(books);
        break;
      case 2:
        listBooks(books);
        break;
      case 3:
        findBook(books);
        break;
      case 4:
        showGenres(books);
        break;
      case 5:
        showBooksByGenre(books);
        break;
      case 0:
        print('Goodbye!');
        return;
    }
  }
}
