enum Assets {
  teddy,
}

extension AssetsValue on Assets {
  String get value {
    switch (this) {
      case Assets.teddy:
        return "assets/rive/login_screen_character.riv";
    }
  }
}
