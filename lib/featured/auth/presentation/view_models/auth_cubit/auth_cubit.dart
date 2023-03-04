import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:moda_store/featured/auth/data/models/admin.dart';

import '../../../../../services/locator.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FacebookAuth faceBookAuth = FacebookAuth.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  late Stream<User?> _authStateChange;
  AuthCubit() : super(const AuthInitial());
  Future googleSingIn()async{
    emit(const AuthLoading());
    try{
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await auth.signInWithCredential(credential).then((value) {
        Admin admin = Admin(username: value.user!.displayName!, email: value.user!.email!, phone: '', adminId: value.user!.uid,
            address: '',
            image: value.user!.photoURL.toString()
        );
        uploadAdminData(admin);
      });
    }catch(e){
      emit(AuthFailed(errMsg: e.toString()));
    }
  }
  Future uploadAdminData(Admin admin) async {
    emit(const AuthLoading());
    try {
      await firebaseFirestore
          .collection('admins')
          .doc(admin.adminId)
          .set(admin.toJson())
          .whenComplete(() async {
            emit(const AuthSuccess());
      });
      getIt.get<GetStorage>().write('id', admin.adminId);
      saveToken();
    } catch (e) {
         emit(AuthFailed(errMsg: e.toString()));
    }
  }
  Future signup({required Admin admin,required String password})async{
    emit(const AuthLoading());
    try {
       await auth.createUserWithEmailAndPassword(
        email: admin.email,
        password: password,
      ).then((value){
        admin.adminId = value.user!.uid;
        uploadAdminData(admin);
      });

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(const AuthFailed(errMsg: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(const AuthFailed(errMsg: 'The account already exists for that email.'));
      }
    } catch (e) {
      emit(const AuthFailed(errMsg: 'The account already exists for that email.'));
    }
  }
  Future facebookSingIn()async{
    emit(const AuthLoading());

    try{
      final LoginResult loginResult = await faceBookAuth.login();

      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

      await auth.signInWithCredential(facebookAuthCredential).then((value){

        Admin admin= Admin(
          username: value.user!.displayName.toString(),
          email: value.user!.email.toString(),
          adminId: value.user!.uid,
          phone: value.user!.phoneNumber.toString(),
          address: '',
          image: value.user!.photoURL.toString()
        );
      uploadAdminData(admin);
      });


    }catch(e){
      emit(const AuthLoading());


    }
  }
  Future login({required String email, required String password})async{
    emit(const AuthLoading());
    try {
      await auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      saveToken();
      emit(const AuthSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(const AuthFailed(errMsg: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(const AuthFailed(errMsg: 'Wrong password provided for that user.'));
      }
    }
  }
saveToken()async{
  _authStateChange = auth.authStateChanges();
  _authStateChange.listen((user)async {
     if(user != null){
       var token = await user.getIdToken();
       getIt.get<GetStorage>().write('token', token);
     }
  });
  emit(const IsLoggedIn());
}
logoutSession()async{
    try{
  await auth.signOut().then((value){
    emit(const IsLoggedOut());
    getIt.get<GetStorage>().remove('token');
  });
    }catch(e){
       emit(AuthFailed(errMsg: e.toString()));
    }
}
checkSession(){
    var token = getIt.get<GetStorage>().read('token');
    if(token != null){
      emit(const IsLoggedIn());
    }else{
      emit(const IsLoggedOut());
    }
}
}
