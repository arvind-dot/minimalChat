import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minimal_chat/components/chat_bubble.dart';
import 'package:minimal_chat/components/my_textfield.dart';
import 'package:minimal_chat/services/auth/auth_service.dart';
import 'package:minimal_chat/services/chat/chat_service.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverId;
  ChatPage({super.key, required this.receiverEmail, required this.receiverId});

  // text controller for message input
  final TextEditingController _messageController = TextEditingController();

  //chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  
  //send message
  void sendMessage() async {
    if(_messageController.text.isNotEmpty){
     await _chatService.sendMessage(receiverId, _messageController.text);
      _messageController.clear();
    }
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(receiverEmail),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
      ),
      body: Column(
        children: [
          //display all messages
          Expanded(child : _buildMessageList()),

          //user input
          _buildUserInput(),
        ],
      ),
    );
  }
  
  Widget _buildMessageList() {
    String senderId = _authService.getcurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(senderId, receiverId), 
      builder: (context, snapshot){
        if(snapshot.hasError){
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if(!snapshot.hasData){
          return Center(
            child: Text("No messages found."),
          );
        }
        if(snapshot.data!.docs.isEmpty){
          return Center(
            child: Text("No messages found."),
          );
        }
        return ListView(
          children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );

      }
      );
  }

 Widget _buildMessageItem(DocumentSnapshot doc) {
  Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

  //is current user
  bool isCurrentUser = data['senderId'] == _authService.getcurrentUser()!.uid;
  
  //message bubble to the right if sender is current user; otherwise to the left
  return Row(
    mainAxisAlignment: isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
    children: [
      ChatBubble(message: data['message'], isCurrentUser: isCurrentUser)

      // Container(
      //   padding: const EdgeInsets.all(10),
      //   margin: const EdgeInsets.all(10),
      //   decoration: BoxDecoration(
      //     color: isCurrentUser ? Colors.blue : Colors.grey,
      //     borderRadius: BorderRadius.circular(10),
      //   ),
      //   child: Text(data['message'], style: const TextStyle(color: Colors.white),),
      // ),
    ],
  );


  

 }

 Widget _buildUserInput(){
  return Padding(
    padding: const EdgeInsets.only(bottom: 50.0),
    child: Row(
      children: [
        Expanded(child: MyTextfield(hintText: "Type a message", controller: _messageController)     
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(50),
          ),
          margin: const EdgeInsets.only(right: 25),
          child: IconButton(
            onPressed: sendMessage,
            icon: const Icon(Icons.arrow_upward, color: Colors.white),
          ),
        )
    ],
    ),
  );
 }
}