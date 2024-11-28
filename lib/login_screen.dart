import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _keyForm = GlobalKey<FormState>();
  final _userNameKey = GlobalKey<FormFieldState>();
  final _passWordKey = GlobalKey<FormFieldState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isPassWordShow = false;
  String _messageLogin = '';

  void onCheckPassWord() {
    isPassWordShow = !isPassWordShow;
    setState(() {});
  }

  onLogin() {
    _keyForm.currentState!.validate();
    if (_passwordController.text == 'admin') {
      setState(() {
        _messageLogin = "Login successfully!";
      });
    } else {
      setState(() {
        _messageLogin = "Password is incorrect.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 50),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.withOpacity(0.12),
              Colors.purple.withOpacity(0.12),
            ],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
        ),
        child: Form(
          key: _keyForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              // Username/Email TextField
              TextFormField(
                key: _userNameKey,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Username is required";
                  }
                  return null;
                },
                controller: _usernameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Username, email or mobile number',
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Password TextField
              TextFormField(
                key: _passWordKey,
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is required";
                  }
                  return null;
                },
                obscureText: !isPassWordShow,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: Material(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: isPassWordShow
                          ? IconButton(
                              onPressed: onCheckPassWord,
                              icon: const Icon(CupertinoIcons.eye_fill))
                          : IconButton(
                              onPressed: onCheckPassWord,
                              icon: const Icon(CupertinoIcons.eye_slash_fill)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (_messageLogin.isNotEmpty)
                Text(
                  _messageLogin,
                  style: TextStyle(
                    color: _messageLogin == "Login successfully!"
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(height: 20),
              // Log In Button
              ElevatedButton(
                onPressed: onLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 129, 235),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Log in',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
