import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/screens/chatBuble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
   static String id = 'ChatPage';
   final _controller =ScrollController();
   TextEditingController controller = TextEditingController();

   CollectionReference messages =
   FirebaseFirestore.instance.collection(kMessageCollections);

  ChatPage({super.key});

  @override
  Widget build(BuildContext context ) {
   var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt,descending: true).snapshots(),
      builder: (context,snapshot) {
        if(snapshot.hasData) {
          List<Message> messagesList = [];
          for( int i = 0; i < snapshot.data!.docs.length; i++)
            {
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: kPrimaryColor,
                  centerTitle: true,
                  title: const Text('Chat app'),
                ),
                body:Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        controller: _controller,
                        physics: const ClampingScrollPhysics(),
                        itemCount: messagesList.length,
                        itemBuilder:(context,index)
                      {
                        return messagesList[index].id == email ? ChatBuble(message: messagesList[index],
                        ) : ChatBubleForFriend( message: messagesList[index]);
                      },

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: controller,
                        onFieldSubmitted: (data)
                        {
                          messages.add({
                            kMessage: data,
                            kCreatedAt: DateTime.now(),
                            kId: email,
                          });
                          controller.clear();
                          _controller.animateTo(
                            _controller.position.maxScrollExtent,
                          curve: Curves.easeIn,
                          duration: const Duration(milliseconds: 500));
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                          hintText: 'Send Message ',
                          suffixIcon: Icon(Icons.send,color: kPrimaryColor,)
                        ),
                      ),
                    )
                  ],
                )
            );
          }else
            {
             return  const CircularProgressIndicator(
                color: kPrimaryColor,
              );
            }
      },
    );
  }


}
