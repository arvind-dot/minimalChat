import 'package:flutter/material.dart';
import 'package:minimal_chat/components/my_drawer.dart';
import 'package:minimal_chat/components/user_tile.dart';
import 'package:minimal_chat/pages/chat_page.dart';
import 'package:minimal_chat/services/auth/auth_service.dart';
import 'package:minimal_chat/services/chat/chat_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final AuthService _authservice = AuthService();
  final ChatService _chatservice = ChatService();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),       
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatservice.getUsersStream(),
      builder: (context, snapshot) {
        // Error
        if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        }
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        // Check for null data
        if (!snapshot.hasData) {
          print("Snapshot has no data.");
          return Center(
            child: Text("No users found."),
          );
        }
        // Check for empty list
        if (snapshot.data!.isEmpty) {
          print("Snapshot data is empty.");
          return Center(
            child: Text("No users found."),
          );
        }
        // List of users
        print("User data: ${snapshot.data}");
        return ListView(
          children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData, context)).toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    // Display all users except current user
    print("**Email** "+(_authservice.getcurrentUser()!.email ?? ''));
    if(userData['Email'] != _authservice.getcurrentUser()!.email){
       return UserTile(
      text: userData['Email'],
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              receiverEmail: userData['Email'],
              receiverId: userData['uid'],
            ),
          ),
        );
      },
    );
    }
    else{
      return Container();
    }   
  }
  
}