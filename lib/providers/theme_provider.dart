import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messenger/enums/shared_preference_enum.dart';
import 'package:messenger/services/shared_preference_service.dart';

class ThemeProvider extends ChangeNotifier {
  bool _material3 = true;
  Color _primaryColorLight = Colors.purple;
  Color _secondaryColorLight = Colors.purple.shade300;
  Color? _primaryTextColorLight;
  Color _primaryColorDark = Colors.purple;
  Color _secondaryColorDark = Colors.purple.shade700;
  Color? _primaryTextColorDark;
  ThemeMode? _themeMode;

  get _lightThemeData => ThemeData.light(useMaterial3: _material3);

  get _darkThemeData => ThemeData.dark(useMaterial3: _material3);

  bool get material3 => _material3;

  bool isDarkMode() {
    if (_themeMode != null) {
      return _themeMode == ThemeMode.dark;
    }
    return SchedulerBinding.instance.platformDispatcher.platformBrightness ==
        Brightness.dark;
  }

  get themeData => _lightThemeData.copyWith(
        primaryColor: _primaryColorLight,
        primaryColorLight: _primaryColorLight.withOpacity(0.3),
        textTheme: _lightThemeData.textTheme.apply(
          bodyColor: _primaryTextColorLight,
          fontFamily: GoogleFonts.aBeeZee().fontFamily,
        ),
        colorScheme: _lightThemeData.colorScheme.copyWith(
          primary: _primaryColorLight,
          secondary: _secondaryColorLight,
        ),
      );

  get darkThemeData => _darkThemeData.copyWith(
        primaryColor: _primaryColorDark,
        primaryColorLight: _primaryColorDark.withOpacity(0.3),
        textTheme: _darkThemeData.textTheme.apply(
          bodyColor: _primaryTextColorDark,
          fontFamily: GoogleFonts.aBeeZee().fontFamily,
        ),
        colorScheme: _darkThemeData.colorScheme.copyWith(
          primary: _primaryColorDark,
          secondary: _secondaryColorDark,
        ),
      );

  ThemeMode? get themeMode => _themeMode;

  Future<void> init() async {
    await _getThemeFromSP();
    await _getColorsFromSP();
    notifyListeners();
  }

  Future<void> _getThemeFromSP() async {
    var darkModeValue = await SharedPreferenceService.getBoolean(
      SharedPreferenceEnum.darkMode,
    );
    var material3Value = await SharedPreferenceService.getBoolean(
      SharedPreferenceEnum.material3,
    );

    if (darkModeValue != null) {
      _themeMode = darkModeValue == true ? ThemeMode.dark : ThemeMode.light;
    }
    _material3 = material3Value ?? true;
  }

  Future<void> _getColorsFromSP() async {
    var primaryColorLightValue = await SharedPreferenceService.getInt(
      SharedPreferenceEnum.primaryColorLight,
    );
    var secondaryColorLightValue = await SharedPreferenceService.getInt(
      SharedPreferenceEnum.secondaryColorLight,
    );
    var primaryTextColorLightValue = await SharedPreferenceService.getInt(
      SharedPreferenceEnum.primaryTextColorLight,
    );
    var primaryColorDarkValue = await SharedPreferenceService.getInt(
      SharedPreferenceEnum.primaryColorDark,
    );
    var secondaryColorDarkValue = await SharedPreferenceService.getInt(
      SharedPreferenceEnum.secondaryColorDark,
    );
    var primaryTextColorDarkValue = await SharedPreferenceService.getInt(
      SharedPreferenceEnum.primaryTextColorDark,
    );

    if (primaryColorLightValue != null) {
      _primaryColorLight = Color(primaryColorLightValue);
    }
    if (secondaryColorLightValue != null) {
      _secondaryColorLight = Color(secondaryColorLightValue);
    }
    if (primaryTextColorLightValue != null) {
      _primaryTextColorLight = Color(primaryTextColorLightValue);
    }
    if (primaryColorDarkValue != null) {
      _primaryColorDark = Color(primaryColorDarkValue);
    }
    if (secondaryColorDarkValue != null) {
      _secondaryColorDark = Color(secondaryColorDarkValue);
    }
    if (primaryTextColorDarkValue != null) {
      _primaryTextColorDark = Color(primaryTextColorDarkValue);
    }
  }

  void setDarkMode(bool value) {
    _themeMode = value ? ThemeMode.dark : ThemeMode.light;
    SharedPreferenceService.setBool(SharedPreferenceEnum.darkMode, value);
    notifyListeners();
  }

  void setMaterial3(bool value) {
    _material3 = value;
    SharedPreferenceService.setBool(SharedPreferenceEnum.material3, value);
    notifyListeners();
  }

  void setPrimaryColor(Color color) {
    SharedPreferenceEnum spKey;
    if (isDarkMode()) {
      _primaryColorDark = color;
      spKey = SharedPreferenceEnum.primaryColorDark;
    } else {
      _primaryColorLight = color;
      spKey = SharedPreferenceEnum.primaryColorLight;
    }

    SharedPreferenceService.setInt(
      spKey,
      color.value,
    );
    notifyListeners();
  }

  void setPrimaryTextColor(Color color) {
    SharedPreferenceEnum spKey;
    if (isDarkMode()) {
      _primaryTextColorDark = color;
      spKey = SharedPreferenceEnum.primaryTextColorDark;
    } else {
      _primaryTextColorLight = color;
      spKey = SharedPreferenceEnum.primaryTextColorLight;
    }

    SharedPreferenceService.setInt(
      spKey,
      color.value,
    );
    notifyListeners();
  }

  void setSecondaryColor(Color color) {
    SharedPreferenceEnum spKey;
    if (isDarkMode()) {
      _secondaryColorDark = color;
      spKey = SharedPreferenceEnum.secondaryColorDark;
    } else {
      _secondaryColorLight = color;
      spKey = SharedPreferenceEnum.secondaryColorLight;
    }

    SharedPreferenceService.setInt(
      spKey,
      color.value,
    );

    notifyListeners();
  }

  bool getIsDarkMode(BuildContext context) {
    if (themeMode != null) {
      return themeMode == ThemeMode.dark;
    } else {
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
  }

  void toggleDarkMode() {
    var value = _themeMode == ThemeMode.dark;
    setDarkMode(!value);
  }

  void toggleMaterial3() {
    setMaterial3(!material3);
  }
}
