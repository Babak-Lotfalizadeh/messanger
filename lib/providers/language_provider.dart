import 'package:flutter/cupertino.dart';
import 'package:messenger/enums/shared_preference_enum.dart';
import 'package:messenger/services/shared_preference_service.dart';

class LanguageProvider extends ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  Future<void> init() async {
    var code = await SharedPreferenceService.getString(
      SharedPreferenceEnum.language,
    );
    var country = await SharedPreferenceService.getString(
      SharedPreferenceEnum.country,
    );
    _locale = Locale(code ?? "en", country ?? "US");
    notifyListeners();
  }

  void _setLanguage(String code, String country) async {
    _locale = Locale(code, country);
    await SharedPreferenceService.setString(
      SharedPreferenceEnum.language,
      code,
    );
    await SharedPreferenceService.setString(
      SharedPreferenceEnum.country,
      country,
    );
    notifyListeners();
  }

  void setEnglishLanguage() => _setLanguage('en', 'US');

  void setPersianLanguage() => _setLanguage('fa', 'IR');
}
