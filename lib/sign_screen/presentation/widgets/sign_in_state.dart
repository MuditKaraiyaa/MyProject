import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:xbridge/common/constants/app_colors.dart';
import 'package:xbridge/common/constants/app_image.dart';
import 'package:xbridge/common/constants/constants.dart';
import 'package:xbridge/common/constants/globals.dart';
import 'package:xbridge/common/constants/route_constants.dart';
import 'package:xbridge/common/service/auth_service.dart';
import 'package:xbridge/common/service/database_service.dart';
import 'package:xbridge/common/theme/eleveated_button_style.dart';
import 'package:xbridge/common/theme/styles.dart';
import 'package:xbridge/common/utils/helper_function.dart';
import 'package:xbridge/common/widgets/loader.dart';
import 'package:xbridge/sign_screen/controller/sign_in_block.dart';
import 'package:xbridge/sign_screen/controller/sign_in_event.dart';
import 'package:xbridge/sign_screen/controller/sign_in_state.dart';
import 'package:xbridge/sign_screen/presentation/screen/sign_in.dart';

class SignInScreenState extends State<SignIn> {
  late SignInBloc signInBloc;

  SignInScreenState();

  bool passwordVisible = false;
  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  AuthService authService = AuthService();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
    signInBloc = BlocProvider.of<SignInBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) async {
          if (state is SignInLoadingState) {
            setState(() {
              isLoading = true;
            });
          } else if (state is SignInLoadedState) {
            if (state.response.result.result == "success") {
              authService.loginWitAnonymously().then((value) async {
                if (value == true) {
                  QuerySnapshot snapshot = await DatabaseService(
                    uid: FirebaseAuth.instance.currentUser!.uid,
                  ).gettingUserData(state.response.result.userName);
                  // saving the values to our shared preferences
                  await HelperFunctions.saveUserLoggedInStatus(true);
                  await HelperFunctions.saveUserEmailSF(
                    state.response.result.userName,
                  );
                  await HelperFunctions.saveUserNameSF(
                    snapshot.docs[0]['fullName'],
                  );
                } else {
                  showSnackbar(context, Colors.red, value);
                }
              });
              setState(() {
                setupGlobalVariables(state);
                isLoading = false;
              });
              if (mounted) {
                if (userType == UserType.agent) {
                  GoRouter.of(context).pushNamed(
                    RouteConstants.sdAgent,
                  );
                } else {
                  GoRouter.of(context).go('/${RouteConstants.tabBar}');
                }
              }
            }
          } else if (state is SignInErrorState) {
            userName = "";
            setState(() {
              isLoading = false;
            });
            showAlertDialog(context, state.message);
          }
        },
        child: BlocBuilder<SignInBloc, SignInState>(
          builder: (context, state) {
            return SafeArea(child: getInitUI());
          },
        ),
      ),
    );
  }

  void setupGlobalVariables(SignInLoadedState state) {
    userName = state.response.result.userName;
    userType = state.response.result.agentType == "Field Engineer"
        ? UserType.fe
        : state.response.result.agentType == "SD Agent"
            ? UserType.agent
            : UserType.fm;
    firstName = state.response.result.firstName;
    lastName = state.response.result.lastName;
    userSysId = state.response.result.sysId;
    vendorName = state.response.result.vendorName;
  }

  Widget getInitUI() {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Image(
                image: AssetImage(AppImage.loginHeader),
                width: 210.w,
                height: 150.h,
              ),
            ),
            Image(
              image: AssetImage(AppImage.loginCenter),
              width: 245.w,
              height: 247.h,
            ),
            Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formGlobalKey,
              child: Container(
                padding: EdgeInsets.only(top: 10.h, left: 19.w, right: 19.w),
                margin: EdgeInsets.only(top: 28.h, left: 17.w, right: 17.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Welcome",
                      style: Styles.textStyledarkRed22dpRegular,
                    ),
                    TextFormField(
                      focusNode: emailFocusNode,
                      controller: emailController,
                      cursorColor: AppColors.red,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter username';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.red),
                        ),
                        hintText: "Username",
                        hintStyle:
                            Styles.textStyleTextFieldPlaceHolder11dpRegular,
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(passwordFocusNode);
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormField(
                      cursorColor: AppColors.red,
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter password';
                        } else if (value.length < 6) {
                          return 'Password should have minimum 6 characters';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.red),
                        ),
                        prefixIconConstraints:
                            const BoxConstraints(minWidth: 0, minHeight: 0),
                        prefixIcon: Image(
                          image: AssetImage(AppImage.loginPasswordLock),
                          width: 25.w,
                          height: 16.h,
                        ),
                        hintText: "Password",
                        hintStyle:
                            Styles.textStyleTextFieldPlaceHolder11dpRegular,
                      ),
                      onFieldSubmitted: (value) {
                        if (formGlobalKey.currentState!.validate()) {
                          formGlobalKey.currentState?.save();
                          signInBloc.add(
                            SignInVerificationEvent(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                        }
                      },
                      focusNode: passwordFocusNode,
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    SizedBox(
                      height: 50.h,
                      child: isLoading
                          ? const Loader()
                          : ElevatedButton(
                              onPressed: () async {
                                if (formGlobalKey.currentState!.validate()) {
                                  formGlobalKey.currentState?.save();
                                  signInBloc.add(
                                    SignInVerificationEvent(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    ),
                                  );
                                }
                              },
                              style:
                                  CustomElevatedButtonStyle.primaryButtonStyle(
                                backgroundColor:
                                    AppColors.primaryButtonBackgroundColor,
                              ),
                              child: Text(
                                kReleaseMode
                                    ? Constants.signInLogin
                                    : Constants.signInLogin,
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.4.sp,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, String msg) {
    Widget okButton = TextButton(
      child: const Text("Ok"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(Constants.appName),
      content: Text(
        "Please Enter Valid Credentials",
        style: Styles.textStyledarkBlack12dpRegular,
      ),
      actions: [okButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
