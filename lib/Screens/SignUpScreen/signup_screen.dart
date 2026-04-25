import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:riverpod_learn/Helper/custom_autoComplete.dart';
import 'package:riverpod_learn/Helper/custom_drop_down.dart';
import 'package:riverpod_learn/Helper/custom_text_field.dart';
import 'package:riverpod_learn/Screens/SignUpScreen/signup_notifier.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  late TextEditingController nameCtr;
  late TextEditingController emailCtr;
  late TextEditingController phoneCtr;
  late TextEditingController passwordCtr;
  late TextEditingController cityCtr;

  List<String> dropdownList = ["Select", "Male", "Female", "Others"];
  List<String> cityList = ["Delhi", "Mumbai", "Kolkata", "Ahmedabad", "Bangalore"];

  SuggestionsController<String> suggestionCtr = SuggestionsController();
  FocusNode cityFocus = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameCtr = TextEditingController();
    phoneCtr = TextEditingController();
    passwordCtr = TextEditingController();
    emailCtr = TextEditingController();
    cityCtr = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameCtr.dispose();
    emailCtr.dispose();
    passwordCtr.dispose();
    cityCtr.dispose();
    phoneCtr.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signUpProvider);
    final notifier = ref.read(signUpProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Signup",
                    style: TextStyle(fontSize: 30),
                  ),
                  CustomTextFiled.textFiledCustom(
                    controller: nameCtr,
                    labelText: "Name",
                    onChanged: notifier.updateName,
                  ),
                  CustomTextFiled.textFiledCustom(
                    controller: emailCtr,
                    labelText: "Email",
                    onChanged: notifier.updateEmail,
                  ),
                  CustomTextFiled.textFiledCustom(
                    controller: phoneCtr,
                    labelText: "Phone",
                    onChanged: notifier.updatePhoneNo,
                  ),
                  CustomTextFiled.textFiledCustom(
                      controller: passwordCtr,
                      labelText: "Password",
                      onChanged: notifier.updatePassword,
                      obscureText: state.passwordHide ? true : false,
                      suffixIcon: IconButton(
                          onPressed: notifier.passwordVisibility,
                          icon: Icon(state.passwordHide ? Icons.visibility : Icons.visibility_off))),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CustomDropDown.customDropDownFiled(
                        defaultValue: state.qualification,
                        dropDownList: dropdownList,
                        onChanged: (String? newValue) {
                          notifier.updateQualificationVaue(newValue!);
                        }),
                  ),
                  CustomAutoComplete.customAutoCompleteField(
                    suggestionsController: suggestionCtr,
                    controller: cityCtr,
                    focusNode: cityFocus,
                    listData: cityList,
                    onChanged: (data) {
                      notifier.updateCity(data);
                    },
                    onSelected: (v) {
                      notifier.updateCity(v);
                      suggestionCtr.close();
                      cityFocus.unfocus();
                    },
                  ),
                  Row(
                    children: [
                      const Text("Terms and condition apply"),
                      Checkbox(
                          value: state.termAndCondition,
                          onChanged: (v) {
                            notifier.updateTermsAndCondition(v!);
                          })
                    ],
                  ),
                  Row(
                    children: [Expanded(child: Text("Age Slider")), Text("Age is ${state.age.toStringAsFixed(0)}")],
                  ),
                  Slider(
                      max: 100,
                      min: 0,
                      value: state.age,
                      onChanged: (v) {
                        notifier.updateAge(v);
                      }),
                  Text("Select Gender"),
                  Row(
                    children: [
                      Expanded(
                          child: RadioListTile<String>(
                        visualDensity: VisualDensity.compact,
                        title: const Text("Male"),
                        value: "Male",
                        groupValue: state.radioValue,
                        onChanged: (value) {
                          notifier.updateRadioValue(value!);
                        },
                      )),
                      Expanded(
                          child: RadioListTile<String>(
                        visualDensity: VisualDensity.compact,
                        title: const Text("Female"),
                        value: "Female",
                        groupValue: state.radioValue,
                        onChanged: (value) {
                          notifier.updateRadioValue(value!);
                        },
                      )),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: state.isLoading
                        ? null
                        : () async {
                            final success = await notifier.signUp(context);
                            if (success) {
                              notifier.clearForm();
                              nameCtr.clear();
                              phoneCtr.clear();
                              passwordCtr.clear();
                              emailCtr.clear();
                            }
                          },
                    child: state.isLoading ? const CircularProgressIndicator() : const Text("SignUp"),
                  ),
                  SizedBox(height: 20),
                  RichText(
                      text: TextSpan(
                          text: "Already have an account ? ",
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          children: [
                        TextSpan(
                            text: "Login",
                            style: const TextStyle(color: Colors.red, decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                notifier.clearForm();
                                nameCtr.clear();
                                phoneCtr.clear();
                                passwordCtr.clear();
                                emailCtr.clear();
                                Navigator.pop(context);
                              }),
                      ]))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
