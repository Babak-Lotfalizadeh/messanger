enum FirebaseErrorEnum {
  weakPassword,
  emailAlreadyInUse,
}

extension FirebaseErrorEnumCode on FirebaseErrorEnum {
  String get code {
    switch (this) {
      case FirebaseErrorEnum.weakPassword:
        return "weak-password";
      case FirebaseErrorEnum.emailAlreadyInUse:
        return "email-already-in-use";
    }
  }
}
