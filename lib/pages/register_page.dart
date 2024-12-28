
import 'package:flutter/material.dart';
import 'package:minimal_chat/services/auth/auth_service.dart';
import 'package:minimal_chat/components/my_button.dart';
import 'package:minimal_chat/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _pwdConfController = TextEditingController();
  final void Function()? onTap;

  RegisterPage({super.key,required this.onTap});

  void register(BuildContext context){
    final auth = AuthService();
    //password match create user
    if (_passwordController.text == _pwdConfController.text){
      try {
        auth.signUpWithEmailAndPassword(_emailController.text, _passwordController.text);
      } catch (e) {
        showDialog(context: context, builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))
          ],
        ));
      }
      
    } else //passwords do not match show error
    {
      showDialog(context: context, builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Passwords do not match'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))
          ],
        ));
    }
    
    
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
            Text("Welcome, let's get started!",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16
            ),
            ),

            const SizedBox(height: 25),
            MyTextfield(hintText: 'Email', controller: _emailController,),

            const SizedBox(height: 10),
            MyTextfield(hintText: 'Password', controller: _passwordController,),

            const SizedBox(height: 10),
            MyTextfield(hintText: 'Confirm Password', controller: _pwdConfController,),

            const SizedBox(height: 25),
            MyButton(text: 'Register', onTap: () => register(context),),

            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? ", style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                GestureDetector(
                  onTap: onTap,
                  child: Text("Login now",style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary),))
              ],
            )

          ],
        ),      
      )
    );
  }

  
}