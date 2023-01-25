enum FirebaseLoginErrorEnum {
  userNotFound,
  wrongPassword,
}

extension FirebaseLoginErrorEnumCode on FirebaseLoginErrorEnum {
  String get code {
    switch (this) {
      case FirebaseLoginErrorEnum.userNotFound:
        return "user-not-found";
      case FirebaseLoginErrorEnum.wrongPassword:
        return "wrong-password";
    }
  }
}
