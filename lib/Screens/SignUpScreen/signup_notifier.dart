import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_learn/Screens/SignUpScreen/signup_state.dart';

final signUpProvider = StateNotifierProvider<SignupNotifier, SignUpState>(
  (ref) => SignupNotifier(),
);

class SignupNotifier extends StateNotifier<SignUpState> {
  SignupNotifier() : super(SignUpState());

  void updateName(String value) {
    state = state.copyWith(name: value);
  }

  void updateEmail(String value) {
    state = state.copyWith(email: value);
  }

  void updatePhoneNo(String value) {
    state = state.copyWith(phoneNo: value);
  }

  void updateAge(double value) {
    state = state.copyWith(age: value);
  }

  void updatePassword(String value) {
    state = state.copyWith(password: value);
  }

  void passwordVisibility() {
    state = state.copyWith(passwordHide: !state.passwordHide);
  }

  void updateGender(String value) {
    state = state.copyWith(gender: value);
  }

  void updateRadioValue(String value) {
    state = state.copyWith(radioValue: value);
  }

  void updateTermsAndCondition(bool value) {
    state = state.copyWith(termAndCondition: value);
  }

  void updateQualificationVaue(String value) {
    state = state.copyWith(qualification: value);
  }

  void updateCity(String value) {
    state = state.copyWith(city: value);
  }

  bool validation(BuildContext context) {
    if (state.name.trim().isEmpty) {
      showMsg(context, "Please Enter Name");
      return false;
    }

    if (state.email.trim().isEmpty) {
      showMsg(context, "Please Enter Email");
      return false;
    }

    if (state.phoneNo.trim().isEmpty) {
      showMsg(context, "Please Enter Phone");
      return false;
    }

    if (state.password.trim().isEmpty) {
      showMsg(context, "Please Enter Password");
      return false;
    }

    if (!state.termAndCondition) {
      showMsg(context, "Please Select Terms And Condition");
      return false;
    }

    if (state.age <= 18) {
      showMsg(context, "Age should be greater than 18");
      return false;
    }

    return true;
  }

  void showMsg(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<bool> signUp(BuildContext context) async {
    if (!validation(context)) return false;

    state = state.copyWith(isLoading: true);

    try {
      await Future.delayed(const Duration(seconds: 2));

      print("Email : ${state.email}");
      print("Password : ${state.password}");

      return true;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
      return false;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void clearForm() {
    state = SignUpState();
  }
}
