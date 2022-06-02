import 'package:e_comarce/home/home_layout.dart';
import 'package:e_comarce/models/user_model.dart';
import 'package:e_comarce/modules/signup/cubit/states.dart';
import 'package:e_comarce/shared/components/components.dart';
import 'package:e_comarce/shared/network/local.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupCubit extends Cubit<SignupStates> {
  FirebaseAuth auth = FirebaseAuth.instance;

  SignupCubit() : super(initialSignupState());

  static SignupCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;

  void createEmail(
      {required email, required password, context, required name}) {
    emit(SignupLoadingState());
    auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userModel = UserModel(
          email: value.user!.email, name: name, uid: value.user!.uid, pic: '');
      FirebaseFirestore.instance.collection('users').doc(value.user!.uid).set(
          userModel!.toMap()).then((value){
        emit(saveUserDataSuccessState());
        emit(SignupSuccessState());
        CacheHelper.saveData(key: "isLogged", value: true);
        Toast(text: "Done Successfully", color: Colors.green, context: context);
        Get.offAll(HomeLayout());
      }).catchError((e) {
        print(e.toString());
      }
      );
    }
    ).catchError((e) {
      emit(SignupErrorState());
      Toast(text: e.toString(), color: Colors.red, context: context);
    });;
  }
}
