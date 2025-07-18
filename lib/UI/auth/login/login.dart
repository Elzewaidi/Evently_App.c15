import 'package:eventlyapp/Tabs/widget/custem_text_feild.dart';
import 'package:eventlyapp/Tabs/widget/custom_elevated_button.dart';
import 'package:eventlyapp/UI/HomeScreen/home_screen.dart';
import 'package:eventlyapp/UI/auth/register/register.dart';
import 'package:eventlyapp/firebase_utlis.dart';
import 'package:eventlyapp/l10n/app_localizations.dart';
import 'package:eventlyapp/providers/user_provider.dart';
import 'package:eventlyapp/utils/app_assets.dart';
import 'package:eventlyapp/utils/app_colors.dart';
import 'package:eventlyapp/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/dailog_utils.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();

  var passwordController = TextEditingController();

  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * .04,
          vertical: height * .02,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(AseetsMnger.logo1, height: height * .3),
                SizedBox(height: height * .02),
                CustomTextFiled(
                  maxLines: 1,
                  hintText: AppLocalizations.of(context)!.email,
                  prefixIcon: Image.asset(AseetsMnger.iconEmail1),

                  controller: emailController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'please enter name';
                    }
                    final bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(text);
                    if (!emailValid) {
                      return 'please enter email valid';
                    }
                    return null; //valid
                  },
                  keyBoardType: TextInputType.emailAddress,
                ),
                SizedBox(height: height * .02),
                CustomTextFiled(
                  maxLines: 1,

                  hintText: AppLocalizations.of(context)!.password,
                  prefixIcon: Image.asset(AseetsMnger.iconPassword),
                  suffixIcon: Image.asset(AseetsMnger.iconShowPassword1),
                  obscureText: true,
                  controller: passwordController,
                  keyBoardType: TextInputType.phone,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'please enter password';
                    }
                    if (text.length < 6) {
                      return 'password should be at least 6 chars';
                    }
                    return null;
                  },
                ),
                SizedBox(height: height * .02),
                Text(
                  AppLocalizations.of(context)!.forget_password,
                  style: AppStyles.bold16Primary(context).copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primaryLight,
                  ),
                  textAlign: TextAlign.end,
                ),
                SizedBox(height: height * .02),
                CustomElevatedButton(
                  onButtonClicked: () {
                    login();
                  },
                  text: AppLocalizations.of(context)!.login,
                ),
                SizedBox(height: height * .02),
                InkWell(
                  onTap: () {
                    //todo:navigate to register screen
                    Navigator.pushReplacementNamed(
                      context,
                      RegisterScreen.routeName,
                    );
                    //login();
                  },
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: AppLocalizations.of(
                            context,
                          )!.do_not_have_an_account,
                          style: AppStyles.medium16Black(context),
                        ),
                        TextSpan(
                          text: AppLocalizations.of(context)!.create_account,

                          style: AppStyles.bold16Primary(context).copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primaryLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height * .02),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        endIndent: 20,
                        indent: 20,
                        thickness: 2,
                        color: AppColors.primaryLight,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.or,
                      style: AppStyles.medium16Primary(context),
                    ),
                    Expanded(
                      child: Divider(
                        endIndent: 20,
                        indent: 20,
                        thickness: 2,
                        color: AppColors.primaryLight,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * .02),
                CustomElevatedButton(
                  onButtonClicked: () {
                    login();
                  },
                  text: AppLocalizations.of(context)!.login_with_google,
                  prefixIconButton: Image.asset(AseetsMnger.icongoogle),
                  backGroundColor: AppColors.whiteColor,
                  textStyle: AppStyles.medium20Primary(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    if (formKey.currentState?.validate() == true) {
      //todo show loading
      DialogUtils.showLoading(context: context, message: 'Waiting');
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        var user = await FirebaseUtlis.readUserFromFireStore(
          credential.user?.uid ?? '',
        );
        if (user == null) {
          return;
        }
        //todo save user to provider
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.upDateUser(user);
        print('login successfully');
        print(credential.user?.uid ?? "");
        //todo hide loading
        DialogUtils.hideLoading(context);
        //todo show loading
        DialogUtils.showMessage(
          context: context,
          message: 'login Successfully',
          title: 'Success',
          posActionName: 'ok',
          posAction: () {
            //todo navigate
            Navigator.pushReplacementNamed(context, Homescreen.routeName);
          },
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          //todo hide loading
          DialogUtils.hideLoading(context);
          //todo show loading
          DialogUtils.showMessage(
            context: context,
            message: 'no user found for that email',
            title: 'Error',
            posActionName: 'ok',
          );
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          //todo hide loading
          DialogUtils.hideLoading(context);
          //todo show loading
          DialogUtils.showMessage(
            context: context,
            message: 'Wrong password provided for that user.',
            title: 'Error',
            posActionName: 'ok',
          );
          print('Wrong password provided for that user.');
        } else if (e.code == 'invalid-credential') {
          //todo hide loading
          DialogUtils.hideLoading(context);
          //todo show loading
          DialogUtils.showMessage(
            context: context,
            message:
                ' The supplied auth credential is incorrect, ,malformed or has expired.',
            title: 'Error',
            posActionName: 'ok',
          );
          print(
            ' The supplied auth credential is incorrect, ,malformed or has expired.',
          );
        } else if (e.code == 'network-request-failed') {
          //todo hide loading
          DialogUtils.hideLoading(context);
          //todo show loading
          DialogUtils.showMessage(
            context: context,
            message:
                '  A network error (such as timeout, interrupted connection or unreachable host) has occurred.',
            title: 'Error',
            posActionName: 'ok',
          );
        }
      } catch (e) {
        //todo hide loading
        DialogUtils.hideLoading(context);
        //todo show loading
        DialogUtils.showMessage(
          context: context,
          message: e.toString(),
          title: 'Error',
          posActionName: 'ok',
        );
      }
      //login
    }
  }
}
