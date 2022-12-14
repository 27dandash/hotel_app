// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/loginModel.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/dio.dart';
import 'package:shop_app/shared/network/endPoints.dart';

import '../../../shared/components/constants.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context)=> BlocProvider.of(context);

  LoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    print('#######data###############');

    print(email);
    print(password);
    emit(LoginLoadingState());
;
    DioHelper.postData(url:loginEndPoint, data: {
      'email':email,
      'password':password,
    }) .then((value){
      loginModel = LoginModel.fromJson(value.data);
      print('######################');
      print(loginModel!.data!);
      token = loginModel!.data!.token;
      emit(LoginSuccessState(loginModel));
    }).catchError((onError) {
      emit(LoginErrorState(onError.toString()));
    });
  }

  IconData suffix = Icons.visibility_rounded;
  bool isPasswordShow = true;

  void changePassword() {
    isPasswordShow = !isPasswordShow;
    suffix = isPasswordShow ? Icons.visibility_rounded : Icons.visibility_off_rounded;
    emit(LoginChangePasswordState());
  }
}