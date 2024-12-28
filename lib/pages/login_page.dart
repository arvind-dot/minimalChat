import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:minimal_chat/services/auth/auth_service.dart';
import 'package:minimal_chat/components/my_button.dart';
import 'package:minimal_chat/components/my_textfield.dart';

class LoginPage extends StatelessWidget{

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final void Function()? onTap;
  LoginPage({super.key,required this.onTap});


  void login(BuildContext context) async{
    // ignore: no_leading_underscores_for_local_identifiers
    final _authService = AuthService();
    try {
      await _authService.signInWithEmailAndPassword(_emailController.text, _passwordController.text);
    } catch (e) {
      if (context.mounted) {
        showDialog(context: context, builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))
          ],
        ));
      }
    }
    log('Email: ${_emailController.text}');
    log('Password: ${_passwordController.text}');
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //icon
            Icon(
            Icons.message_rounded,
            size: 60,
            color: Theme.of(context).colorScheme.primary
            ),

            const SizedBox(height: 50),

            //Text
            Text("Welcome back, you've been missed!",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16
            ),
            ),

            const SizedBox(height: 25),
            MyTextfield(hintText: 'Email', controller: _emailController,),

            const SizedBox(height: 10),
            MyTextfield(hintText: 'Password', controller: _passwordController,),

            const SizedBox(height: 25),
            MyButton(text: 'Login', onTap: () => login(context)),

            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account? ", style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                GestureDetector(
                  onTap: onTap,
                  child: Text("Sign up",style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary),))
              ],
            )

          ],
        ),      
      )
    );
  }
}

