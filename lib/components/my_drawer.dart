import 'package:flutter/material.dart';
import 'package:minimal_chat/services/auth/auth_service.dart';
import 'package:minimal_chat/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //logo
          Column(
            children: [
              DrawerHeader(child: Center(child: Icon(Icons.message, size: 40, color: Theme.of(context).colorScheme.primary))),
              
              //home
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text("H O M E"),            
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
              ),
              
              //settings
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("S E T T I N G S"),            
                  onTap: (){                    
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                  },
                ),
              ),
            ],
          ),

          //logout
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 25),
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text("L O G O U T"),            
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}