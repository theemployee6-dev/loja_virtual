import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual/helpers/firebase_errors.dart';
import '/models/user.dart';

import 'user.dart';

class UserManager extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool loading = false;

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  Future<void> signIn({User user, Function onFail, Function onSuccess}) async {
    setLoading(true);
    try {
      final AuthResult result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);

      print(result.user.uid);
      onSuccess();
    } on PlatformException catch (e) {
      print(e);
      onFail(getErrorString(e.code));
    }
  }
}
