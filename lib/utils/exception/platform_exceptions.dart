class FPlatformExceptions implements Exception {
  final String code;

  const FPlatformExceptions(this.code);

  String get message {
    switch (code) {
      case 'INVALID-LOGIN-CREDENTIALS':
        return 'Invalid login credentials. Pleasedouble-check your email and password';
      case 'INVALID-EMAIL-FORMAT':
        return 'The email address format is invalid. Please enter a valid email';
      case 'too-many-requests':
        return 'Too many requests. Please try again later';
      case 'network-request-failed':
        return 'Network error. Please try again later';
      case 'invalid-phone-number':
        return 'The phone number format is invalid. Please enter a valid phone number';
      case 'sign-in-failed':
        return 'Sign in failed. Please try again later';
      case 'invalid-verification-code':
        return 'The verification code is invalid. Please enter a valid code';
      case 'invalid-password':
        return 'The password is invalid. Please enter a valid password';
      case 'invalid-argument':
        return 'Invalid argument. Please try again later';
      default:
        return 'An unexpected Firebase error occurred. Please try again later';
    }
  }
}
