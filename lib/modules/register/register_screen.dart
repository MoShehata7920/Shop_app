import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/modules/register/cubit/states.dart';

import '../../layout/shop_screen_layout.dart';
import '../../shared/component/component.dart';
import '../../shared/component/constant.dart';
import '../../shared/network/local/cache_helper.dart';
import '../login/cubit/cubit.dart';
import '../login/cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCuibt(),
      child: BlocConsumer<ShopRegisterCuibt, ShopRegisterState>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status!) {
              showToast(
                  text: state.loginModel.message.toString(),
                  state: ToastStates.SUCCESS);
              // ignore: avoid_print
              print(state.loginModel.message);
              // ignore: avoid_print
              print(state.loginModel.data!.token);

              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data!.token!)
                  .then(
                (value) {
                  token = state.loginModel.data!.token!;
                  // ignore: prefer_const_constructors
                  navigateAndFInish(context, ShopLayout());
                },
              );
            } else {
              // ignore: avoid_print
              print(state.loginModel.message!);
              showToast(
                  text: state.loginModel.message!, state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          // ignore: body_might_complete_normally_nullable
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your name';
                            }
                          },
                          label: 'User name',
                          prefix: Icons.person,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          // ignore: body_might_complete_normally_nullable
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          // ignore: body_might_complete_normally_nullable
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Password is too short';
                            }
                          },
                          suffix: ShopRegisterCuibt.get(context).suffix,
                          isPassword: ShopRegisterCuibt.get(context).isPassword,
                          suffixPressed: () {
                            ShopRegisterCuibt.get(context)
                                .changePasswordVisibility();
                          },
                          label: 'Password',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          // ignore: body_might_complete_normally_nullable
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your phone';
                            }
                          },
                          label: 'phone',
                          prefix: Icons.phone,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defaultButton(
                              background: Colors.blue,
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  ShopRegisterCuibt.get(context).userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              text: 'register'),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
