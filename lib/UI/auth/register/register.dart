import 'package:eventlyapp/Model/users.dart';
import 'package:eventlyapp/Tabs/widget/custem_text_feild.dart';
import 'package:eventlyapp/Tabs/widget/custom_elevated_button.dart';
import 'package:eventlyapp/UI/HomeScreen/home_screen.dart';
import 'package:eventlyapp/UI/auth/login/login.dart';
import 'package:eventlyapp/firebase_utlis.dart';
import 'package:eventlyapp/l10n/app_localizations.dart';
import 'package:eventlyapp/utils/app_assets.dart';
import 'package:eventlyapp/utils/app_colors.dart';
import 'package:eventlyapp/utils/dailog_utils.dart';
import 'package:eventlyapp/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var rePasswordController = TextEditingController();

  Widget build(BuildContext context) {
    //var formKey = GlobalKey<FormState>();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.register,
          style: AppStyles.medium16Black(context),
        ),
        centerTitle: true,
      ),
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
                Image.asset(AseetsMnger.logo1, height: height * .25),
                CustomTextFiled(
                  maxLines: 1,

                  controller: nameController,
                  validator: (text) {
                    if (text == null || text
                        .trim()
                        .isEmpty) {
                      return 'please enter name';
                    }
                    return null; //valid
                  },
                  hintText: AppLocalizations.of(context)!.name,
                  prefixIcon: Image.asset(AseetsMnger.iconName1),
                ),
                SizedBox(height: height * .02),
                CustomTextFiled(
                  maxLines: 1,
                  keyBoardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: (text) {
                    if (text == null || text
                        .trim()
                        .isEmpty) {
                      return 'please enter email';
                    }
                    final bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(text);
                    if (!emailValid) {
                      return 'please enter email valid';
                    }
                    return null; //valid
                  },
                  hintText: AppLocalizations.of(context)!.email,
                  prefixIcon: Image.asset(AseetsMnger.iconEmail1),
                ),
                SizedBox(height: height * .02),
                CustomTextFiled(
                  maxLines: 1,
                  keyBoardType: TextInputType.phone,
                  controller: passwordController,
                  validator: (text) {
                    if (text == null || text
                        .trim()
                        .isEmpty) {
                      return 'please enter password';
                    }
                    if (text.length < 6) {
                      return 'password should be at least 6 chars';
                    }
                    return null; //valid
                  },
                  hintText: AppLocalizations.of(context)!.password,
                  prefixIcon: Image.asset(AseetsMnger.iconPassword),
                  obscureText: true,
                  suffixIcon: Image.asset(AseetsMnger.iconShowPassword1),
                ),
                SizedBox(height: height * .02),
                CustomTextFiled(
                  maxLines: 1,
                  controller: rePasswordController,
                  validator: (text) {
                    if (text == null || text
                        .trim()
                        .isEmpty) {
                      return 'please enter password';
                    }
                    if (text.length < 6) {
                      return 'password should be at least 6 chars';
                    }
                    if (text != passwordController.text) {
                      return 'rePassword dot match password';
                    }
                    return null; //valid
                  },
                  hintText: AppLocalizations.of(context)!.re_password,
                  prefixIcon: Image.asset(AseetsMnger.iconPassword),
                  obscureText: true,
                  suffixIcon: Image.asset(AseetsMnger.iconShowPassword1),
                ),
                SizedBox(height: height * .02),

                CustomElevatedButton(
                  onButtonClicked: () {
                    register();
                  },
                  text: AppLocalizations.of(context)!.create_account,
                ),
                SizedBox(height: height * .02),
                InkWell(
                  onTap: () {
                    //todo:navigate to register screen
                    Navigator.of(
                      context,
                    ).pushReplacementNamed(LoginScreen.routeName);
                  },
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                          AppLocalizations.of(
                            context,
                          )!.already_hava_an_account,
                          style: AppStyles.medium16Black(context),
                        ),
                        TextSpan(
                          text: AppLocalizations.of(context)!.login,

                          style: AppStyles.bold16Primary(context).copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primaryLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void register() async {
    if (formKey.currentState?.validate() == true) {
      DialogUtils.showLoading(context: context, message: 'Loading...');
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        //todo add user
        MyUser myUser = MyUser(id: credential.user?.uid ?? '',
            name: nameController.text,
            email: emailController.text);
        await FirebaseUtlis.addUserToFireStore(myUser);
        //todo save user to provider
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.upDateUser(myUser);
        //todo hide message
        DialogUtils.hideLoading(context);
        //todo show
        DialogUtils.showMessage(
          context: context,
          message: 'register successfully..',
          title: 'Success',
          posActionName: 'ok',
          posAction: () {
            //todo navigate
            Navigator.pushReplacementNamed(context, Homescreen.routeName);
          },
        );
        print('register successfully');
        print(credential.user?.uid ?? "");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context: context,
              message: 'The password provided is too weak..',
              title: 'Error',
              posActionName: 'ok',
              posAction: () {
                Navigator.of(context).pushNamed(Homescreen.routeName);
              }
          );

          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context: context,
              message: 'The account already exists for that email.',
              title: 'Error',
              posActionName: 'ok'
          );
          print('The account already exists for that email.');
        }
      } catch (e) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context: context,
            message: e.toString(),
            title: 'Error',
            posActionName: 'ok');
      }
    }
  }
}
