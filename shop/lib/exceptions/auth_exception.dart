class AuthException implements Exception {
  static const Map<String, String> errors = {
    'EMAIL_EXISTS': 'E-mail already registered.',
    'OPERATION_NOT_ALLOWED': 'Operation not allowed!',
    'TOO_MANY_ATTEMPTS_TRY_LATER': 'Access temporarily blocked. Try later.',
    'EMAIL_NOT_FOUND': 'Email not found.',
    'INVALID_PASSWORD': 'Entered password does not match.',
    'USER_DISABLED': 'User account has been disabled.',
  };
  final String key;

  AuthException(this.key);

  @override
  String toString() {
    return errors[key] ??
        'There was a problem unfortunately. Please contact support.';
  }
}
