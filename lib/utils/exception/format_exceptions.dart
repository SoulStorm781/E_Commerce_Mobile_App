class FFormatExceptions implements Exception {
  final String message;

  const FFormatExceptions(
      [this.message =
          'An unexpected format error occurred. Please check your input.']);
  // create a format exception from specific message

  factory FFormatExceptions.fromMessage(String message) {
    return FFormatExceptions(message);
  }

  //get corresponding error message
  String get errorMessage => message;

  //create a format exception from error code
  factory FFormatExceptions.fromErrorCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return const FFormatExceptions(
            'The email address format is invalid. Please enter valid email.');

      case 'invalid-phone-number-format':
        return const FFormatExceptions(
            'The phone number format is invalid. Please enter valid phone number.');
      case 'invalid-url-format':
        return const FFormatExceptions(
            'The URL format is invalid. Please enter valid URL.');
      case 'invalid-date-format':
        return const FFormatExceptions(
            'The date format is invalid. Please enter valid date.');
      case 'invalid-credit-card-format':
        return const FFormatExceptions(
            'The credit card format is invalid. Please enter valid credit card number.');
      case 'invalid-numeric-format':
        return const FFormatExceptions(
            'The numeric format is invalid. Please enter valid number.');
      default:
        return const FFormatExceptions();
    }
  }
}
