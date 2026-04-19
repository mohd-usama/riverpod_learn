import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_learn/Screens/LoginScreen/login_notifier.dart';
import 'package:riverpod_learn/Screens/PostScreen/post_screen.dart';

import '../SignUpScreen/signup_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late TextEditingController emailCtr;
  late TextEditingController passwordCtr;

  @override
  void initState() {
    super.initState();
    emailCtr = TextEditingController();
    passwordCtr = TextEditingController();
  }

  @override
  void dispose() {
    emailCtr.dispose();
    passwordCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginProvider);
    final notifier = ref.read(loginProvider.notifier);
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(fontSize: 30),
                  ),
                  TextField(
                    controller: emailCtr,
                    onChanged: notifier.updateEmail,
                    decoration: const InputDecoration(
                      labelText: "Email",
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: passwordCtr,
                    onChanged: notifier.updatePassword,
                    obscureText: state.isPasswordHidden ? false : true,
                    decoration: InputDecoration(
                        labelText: "Password",
                        suffixIcon: IconButton(
                            onPressed: notifier.togglePassword,
                            icon: Icon(state.isPasswordHidden ? Icons.visibility : Icons.visibility_off))),
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: state.rememberMe,
                          onChanged: (v) {
                            notifier.toggleRememberMe(v!);
                          }),
                      const Text("Remember Me")
                    ],
                  ),
                  ElevatedButton(
                    onPressed: state.isLoading
                        ? null
                        : () async {
                      final success = await notifier.login(context);
                      if (!success) return;

                      notifier.clearForm();
                      emailCtr.clear();
                      passwordCtr.clear();

                      if (!context.mounted) return;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const PostScreen()),
                      );
                    },
                    child: state.isLoading ? const CircularProgressIndicator() : const Text("Login"),
                  ),
                  const SizedBox(height: 20),
                  RichText(
                      text: TextSpan(
                          text: "Don't have an account ? ",
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          children: [
                        TextSpan(
                            text: "Sign Up",
                            style: const TextStyle(color: Colors.red, decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => const SignupScreen()));
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
