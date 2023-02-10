import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:messenger/view_model/chat_view_model.dart';
import 'package:messenger/view_model/contact_view_model.dart';
import 'package:messenger/view_model/create_contact_view_model.dart';

class FirebaseFunctionService {
  static FirebaseFunctions? _functions;
  static final FirebaseFunctionService _instance =
      FirebaseFunctionService._internal();

  factory FirebaseFunctionService() {
    return _instance;
  }

  FirebaseFunctionService._internal();

  Future<void> init() async {
    _functions = FirebaseFunctions.instance;
  }

  Future<bool> addMessage({
    required ChatViewModel model,
  }) async {
    try {
      await _functions?.httpsCallable('addMessage').call(model.toJson());
      return true;
    } on FirebaseFunctionsException catch (error) {
      debugPrint(error.code);
      return false;
    }
  }

  List<ContactViewModel>? _convertToListContactViewModel(
    HttpsCallableResult? result,
  ) {
    return List.generate(
      (result?.data as List).length,
      (index) => ContactViewModel.fromJson(
        Map<String, dynamic>.from(result?.data[index] as Map<Object?, Object?>),
      ),
    );
  }

  Future<List<ContactViewModel>?> createContact({
    required CreateContactViewModel model,
  }) async {
    try {
      var result = await _functions?.httpsCallable('createContact').call(
            model.toJson(),
          );
      return _convertToListContactViewModel(result);
    } on FirebaseFunctionsException catch (error) {
      debugPrint(error.code);
    } catch (error) {
      debugPrint(error.toString());
    }
    return null;
  }

  Future<List<ContactViewModel>?> getContacts() async {
    try {
      var result = await _functions?.httpsCallable('getContacts').call();
      return _convertToListContactViewModel(result);
    } on FirebaseFunctionsException catch (error) {
      debugPrint(error.code);
      return null;
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }
}
