import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';

 class ChatBuble extends StatelessWidget {
  const ChatBuble({
     Key? key ,
     required this.message,
      }) :super(key: key);
      final Message message;
       @override
        Widget build(BuildContext context) {
         return Align(
          alignment: Alignment.centerLeft,
child: Container(
margin: const EdgeInsets.all(10),
padding: const EdgeInsets.only(left: 14,top: 14,bottom: 14,right: 16),
decoration: const BoxDecoration(
borderRadius: BorderRadius.only(
topLeft: Radius.circular(30),
topRight: Radius.circular(30),
bottomRight: Radius.circular(30),
),
color: kPrimaryColor,
),
child:  Text(message.message,
style: TextStyle(color: Colors.white),),

),
);
}
  }

  class ChatBubleForFriend extends StatelessWidget {
  const ChatBubleForFriend({
     Key? key ,
     required this.message,
      }) :super(key: key);
      final Message message;
       @override
        Widget build(BuildContext context) {
         return Align(
          alignment: Alignment.centerRight,
child: Container(
margin: const EdgeInsets.all(10),
padding: const EdgeInsets.only(left: 14,top: 14,bottom: 14,right: 16),
decoration: const BoxDecoration(
borderRadius: BorderRadius.only(
topLeft: Radius.circular(30),
topRight: Radius.circular(30),
bottomLeft: Radius.circular(30),
),
color: Color(0xff006D84),
),
child:  Text(message.message,
style: TextStyle(color: Colors.white),),

),
);
}
  }

