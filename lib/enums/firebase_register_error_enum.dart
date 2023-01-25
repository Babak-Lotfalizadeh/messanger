enum FirebaseRegisterErrorEnum {
  weakPassword,
  emailAlreadyInUse,
}

extension FirebaseRegisterErrorEnumCode on FirebaseRegisterErrorEnum {
  String get code {
    switch (this) {
      case FirebaseRegisterErrorEnum.weakPassword:
        return "weak-password";
      case FirebaseRegisterErrorEnum.emailAlreadyInUse:
        return "email-already-in-use";
    }
  }
}
