enum Assets {
  teddy,
  userMan,
  userManNoBackground,
}

extension AssetsValue on Assets {
  String get value {
    switch (this) {
      case Assets.teddy:
        return "assets/rive/login_screen_character.riv";
      case Assets.userMan:
        return "assets/image/man_user.svg";
      case Assets.userManNoBackground:
        return "assets/image/man_user_no_bg.svg";
    }
  }
}
