class LoginState {
  final String email;
  final String password;
  final bool isPasswordHidden;
  final bool rememberMe;
  final bool isLoading;

  LoginState({
    this.email = '',
    this.password = '',
    this.isPasswordHidden = false,
    this.rememberMe = false,
    this.isLoading = false,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? isPasswordHidden,
    bool? rememberMe,
    bool? isLoading,
  }) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
        rememberMe: rememberMe ?? this.rememberMe,
        isLoading: isLoading ?? this.isLoading);
  }
}
