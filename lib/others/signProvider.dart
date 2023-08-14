import 'package:flutter/foundation.dart';
import 'package:signature/signature.dart';

class SignProvider with ChangeNotifier{
  SignatureController _signatureController = SignatureController();

  SignatureController get signatureController => _signatureController;

  void setSController(penColor, bgColor){
    _signatureController = SignatureController(
    penColor: penColor,
    penStrokeWidth: 1,
    exportBackgroundColor: bgColor,
  );

  notifyListeners();
  }
}