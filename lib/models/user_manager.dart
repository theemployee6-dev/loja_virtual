import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '/models/user.dart';
import '/helpers/firebase_errors.dart';

class UserManager extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool loading = false;

  Future<void> signIn({User user, Function onFail, Function onSuccess}) async {
    setLoding(true);
    try {
      final AuthResult result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);

      onSuccess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
      setLoding(false);
    }
  }

  void setLoding(bool value) {
    loading = value;
    notifyListeners();
  }
}
