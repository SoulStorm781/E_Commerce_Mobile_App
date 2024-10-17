class FFirebaseAuthExceptions implements Exception {
  // error code
  final String code;

  //constructor that make error code
  FFirebaseAuthExceptions(this.code);

  //get the error message based on error code
  String get message {
    switch (code) {
      case 'unknown':
        return 'An unknown Firebase error occurred. Please try again later.';
      case 'invalid-custom-token':
        return 'The custom token format is incorrect. Please check your custom token.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'operation-not-allowed':
        return 'Email & Password accounts are not enabled.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      case 'user-disabled':
        return 'The user account has been disabled by an administrator.';
      case 'too-many-requests':
        return 'Too many requests. Try again later.';
      case 'network-request-failed':
        return 'Network error. Please try again later.';
      case 'provider-already-linked':
        return 'The user is already linked to the given provider.';
      case 'requires-recent-login':
        return 'This operation is sensitive and requires recent authentication. Log in again before retrying this request.';
      case 'quota-exceeded':
        return 'The project quota for operation has been exceeded.';
      case 'user-mismatch':
        return 'The supplied credentials do not correspond to the previously signed in user.';
      default:
        return 'An unexpected Firebase error occurred. Please try again later';
    }
  }
}
