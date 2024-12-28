import 'package:flutter/material.dart';
import 'package:minimal_chat/pages/login_page.dart';
import 'package:minimal_chat/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // initially show login page
  bool isLoginPage = true;

  void togglePage() {
    setState(() {
      isLoginPage = !isLoginPage;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return isLoginPage ? LoginPage(onTap: togglePage,) : RegisterPage(onTap: togglePage,);   
  }
}