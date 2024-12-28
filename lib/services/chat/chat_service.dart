import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minimal_chat/models/message.dart';

class ChatService {
  //get instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  
Stream<List<Map<String, dynamic>>> getUsersStream() {
  return _firestore.collection("users").snapshots().map((snapshot) {
   // print("Firestore snapshot: ${snapshot.docs.map((doc) => doc.data()).toList()}");
    return snapshot.docs.map((doc) {
      final user = doc.data();
      return user;
    }).toList();
  });
}

  // send message
  Future<void> sendMessage(String receiverId, message) async{
    //get current user info
    final String currentUserId = _auth.currentUser!.uid;  
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //create new message
    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
    );
    //construct chat room id for two users
    List<String> ids = [currentUserId, receiverId];
    ids.sort();//sort ids to get same chat room id for two users
    String chatRoomId = ids.join('_');
    //add new message to the database
    await _firestore.collection("chat_rooms").doc(chatRoomId).collection("messages").add(newMessage.toMap());
  }

  // get messages
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');
    return _firestore.collection("chat_rooms").doc(chatRoomId).collection("messages").orderBy("timestamp",descending: false).snapshots();

  }

}