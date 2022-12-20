import 'package:messenger/view_model/text_field_rule_model.dart';

enum TextFieldRule {
  email,
  password,
}

extension TextFieldRuleValue on TextFieldRule {
  TextFieldRuleModel get rule {
    switch (this) {
      case TextFieldRule.email:
        return const TextFieldRuleModel(
            minLength: 5,
            regexRule:
                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
      case TextFieldRule.password:
        return const TextFieldRuleModel(
            minLength: 8,
            regexRule:
                r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");
    }
  }
}
