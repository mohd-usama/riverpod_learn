class SignUpState {
  final String name;
  final String email;
  final String phoneNo;
  final String password;
  final bool passwordHide;
  final String gender;
  final double age;
  final String radioValue;
  final bool termAndCondition;
  final bool isLoading;

  SignUpState(
      {this.name = "",
      this.email = "",
      this.phoneNo = "",
      this.password = "",
      this.passwordHide = false,
      this.gender = "Male",
      this.age = 0,
      this.radioValue = "Male",
      this.termAndCondition = false,
      this.isLoading = false});

  SignUpState copyWith({
    String? name,
    String? email,
    String? phoneNo,
    String? password,
    bool? passwordHide,
    String? gender,
    double? age,
    String? radioValue,
    bool? termAndCondition,
    bool? isLoading,
  }) {
    return SignUpState(
        name: name ?? this.name,
        email: email ?? this.email,
        phoneNo: phoneNo ?? this.phoneNo,
        password: password??this.password,
        passwordHide: passwordHide ?? this.passwordHide,
        gender: gender ?? this.gender,
        age: age ?? this.age,
        radioValue: radioValue ?? this.radioValue,
        termAndCondition: termAndCondition ?? this.termAndCondition,
        isLoading: isLoading ?? this.isLoading);
  }
}
