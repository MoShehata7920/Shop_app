import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import '../../../models/login_model.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';

class ShopRegisterCuibt extends Cubit<ShopRegisterState> {
  ShopRegisterCuibt() : super(ShopRegisterInitialState());
  static ShopRegisterCuibt get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
      },
    ).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data!);

      emit(
        ShopRegisterSuccessState(loginModel!),
      );
    }).catchError((error) {
      emit(
        ShopRegisterErrorState(error.toString()),
      );
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off;

    emit(
      ShopRegisterChangePasswordVisibilityState(),
    );
  }
}
