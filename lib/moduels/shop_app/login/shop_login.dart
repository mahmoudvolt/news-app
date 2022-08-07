// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:first/moduels/shop_app/login/cubit/cubit.dart';
import 'package:first/moduels/shop_app/login/cubit/states.dart';
import 'package:first/moduels/shop_app/register/shop_register_screen.dart';
import 'package:first/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>(); // create valdaition
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isPasswordShow = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCuibt(),
      child: BlocConsumer<ShopLoginCuibt, ShopLoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  //ايرور لوحه المفاتيح
                  child: Form //validation
                      (
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        Text(
                          "login  now  to  browse  our  hot  offers",
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "email  address  must  not  be  empty";
                              }
                              return null;
                            },
                            lable: "Email  Address",
                            prefix: Icons.email),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "password  is  too  short";
                            }
                            return null;
                          },
                          lable: "Password",
                          prefix: Icons.lock,
                          suffix: ShopLoginCuibt.get(context).suffix,
                          isPassword: ShopLoginCuibt.get(context).isPassword,
                          suffixPressed: () {
                            ShopLoginCuibt.get(context)
                                .changePasswordVisibility();
                          },
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCuibt.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCuibt.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: "Login",
                            isUpperCase: true,
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't  have  an  account? ",
                            ),
                            defaultTextButton(
                              function: () {
                                navigateTo(
                                  context,
                                  ShopRegisterScreen(),
                                );
                              },
                              text: "Register  now",
                            ),
                          ],
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
