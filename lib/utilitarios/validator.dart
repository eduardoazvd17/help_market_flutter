class Validator {
  // final String email;

  // Validator({this.email});

  bool validaEmail(String email) {
    if (email.contains('@') && email.contains('.')) {
      return true;
    }
    return false;
  }
}
