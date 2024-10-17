class FValidator {
//empty text validation
  static String? validateEmpty(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required.';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email.';
    }
    //regular expression for email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value)) {
      return 'Invalid email address.';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password.';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }

    //check for uppercase letter

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain one uppercase letter.';
    }

    //check for number
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain number.';
    }

    // check for special characters

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain special characters.';
    }
    return null;
  }

  static String? validatephoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number.';
    }
    //regular expression for phone number validation
    final phoneRegex = RegExp(r'^\d{11}$');

    if (!phoneRegex.hasMatch(value)) {
      return 'Invalid phone number(11 digits required).';
    }
    return null;
  }
}
