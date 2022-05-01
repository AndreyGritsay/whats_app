import 'package:firebase_auth/firebase_auth.dart';
import 'package:whats_app/security_storage/security_storage.dart';
import 'package:whats_app/registration/screens/check_screen/check_bloc/check_bloc.dart';

class DataProvider {
   late String _verificationId;
  final _auth = FirebaseAuth.instance;
  late String _tokenId;

  Future<String> toGetTheCode(SendCode sendCode, String phoneNumber) async {
    String _exceptionText = '';

    if ((sendCode == SendCode.sms) || (sendCode == SendCode.phone)) {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential authCredential) async {
          User? user = FirebaseAuth.instance.currentUser;
          if (authCredential.smsCode != null) {
            try {
              await user!.linkWithCredential(authCredential);
            } on FirebaseAuthException catch (e) {
              if (e.code == 'provider-already-linked') {
                await _auth.signInWithCredential(authCredential);
              }
            }
          }
        },
        verificationFailed: (FirebaseAuthException exception) {
          _exceptionText = exception.code;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        codeSent: (String verificationId, int? forceResendingToken) {
          _verificationId = verificationId;
        },
      );
    }
    return _exceptionText;
  }

  Future<void> resendCode(String smsCode) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: smsCode,
    );

    await _auth.signInWithCredential(credential);
    String? tokenId = _auth.currentUser?.uid;
    _tokenId = tokenId!;
  }

  Future<void> updateDisplayName(String name) async {
    await _auth.currentUser?.updateDisplayName(name);
  }
   Future<String?> userName() async {
    return _auth.currentUser?.displayName;
   }

   Future<void> profileCreated () async{
     await SecurityStorage().setTokenId(_tokenId);
   }
}
