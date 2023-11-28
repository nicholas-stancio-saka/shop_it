import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AppStringConverter {
  static String capitalizeEachWord(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text.split(" ").map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      }
      return word;
    }).join(" ");
  }

  static String capitalizeFirstLetter(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  static final currencyFormatter = NumberFormat("#,##0", "id_ID");
  static final longDateFormatter = DateFormat('EEEE, dd MMM yyyy, kk:mm:ss', 'id'); // Senin, 24 Aug 2020, 16:50:40
  static final longDateFormatterWithoutTime = DateFormat('EEEE, dd MMM yyyy', 'id'); // Senin, 24 Aug 2020
  static final shortDateFormatter = DateFormat('dd-MM-yy', 'id'); // 24-08-20
  static final longTimeFormatter = DateFormat('kk:mm:ss', 'id'); // 16:50:40
  static final shortTimeFormatter = DateFormat('kk:mm:ss', 'id'); // 16:50

  // ----- Smart Converter -----
  static String smartConverter(String input) {
    try {
      // Replace underscores with spaces to handle snake_case
      input = input.replaceAll('_', ' ');

      // Split the string into words
      List<String> words = input.split(' ');

      // Capitalize the first letter of each word and join them back into a single string
      return words.map((word) {
        // Check if word is in camelCase
        if (word.isNotEmpty && isCamelCase(word)) {
          // Split camelCase word into individual words
          return splitCamelCase(word).map((w) => capitalize(w)).join(' ');
        }
        // Not camelCase, just capitalize
        return capitalize(word);
      }).join(' ');
    } catch (e) {
      return input;
    }
  }

// Function to capitalize the first letter of a string
  static String capitalize(String s) => s.isNotEmpty ? s[0].toUpperCase() + s.substring(1).toLowerCase() : s;

// Function to check if a string is in camelCase
  static bool isCamelCase(String s) => s.isNotEmpty && !s.contains(' ') && (s != s.toLowerCase() && s != s.toUpperCase());

// Function to split a camelCase string into individual words
  static List<String> splitCamelCase(String s) {
    RegExp regExp = RegExp(r'(?<=[a-z])(?=[A-Z])');
    return s.split(regExp);
  }
}

// TODO: BUG: JUMPS WHEN TYPING MID WAY
class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll('.', '');

    if (newText.length <= 3) {
      return newValue;
    }

    String formattedText = '';
    for (int i = newText.length - 1, j = 0; i >= 0; i--, j++) {
      if (j % 3 == 0 && j != 0) {
        formattedText = '.$formattedText';
      }
      formattedText = newText[i] + formattedText;
    }

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
