import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_chatapp/api/api.dart';
import 'package:firebase_chatapp/helper/my_date_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_chatapp/models/user_chat.dart';
import '../main.dart';
import '../models/message.dart';
import '../screens/chat_screen.dart';
import 'dialogs/profile_dialog.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;

  const ChatUserCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  //last message info (if null --> no message)
  Message? _message;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * .04, vertical: 4),
      // color: Colors.blue.shade100,
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => ChatScreen(user: widget.user)));
        },
        child: StreamBuilder(
            stream: APIs.getLastMessage(widget.user),
            builder: (context, snapshot) {
              final data = snapshot.data!.docs;
              final list = data.map((e) => Message.fromJson(e.data())).toList();
              if (list.isNotEmpty) _message = list[0];

              return ListTile(
                //user profile picture
                // leading: CircleAvatar(child: Image.network(user.image)),
                leading: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => ProfileDialog(user: widget.user),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(mq.height * .03),
                    child: CachedNetworkImage(
                      width: mq.height * .055,
                      height: mq.height * .055,
                      imageUrl: widget.user.image,
                      errorWidget: (context, url, error) => const CircleAvatar(
                          child: Icon(CupertinoIcons.person)),
                    ),
                  ),
                ),

                //user name
                title: Text(widget.user.name),

                //last message
                subtitle: _message != null
                    ? _message!.type == Type.text
                        ? Text(
                            _message!.msg,
                            maxLines: 1,
                          )
                        : Row(
                            children: const [
                              Icon(Icons.image_rounded, size: 15),
                              SizedBox(width: 2),
                              Text('Photo')
                            ],
                          )
                    : Text(widget.user.about),

                //last message time
                // trailing: const Text(
                //   '12:00 PM',
                //   style: TextStyle(color: Colors.black54),
                // ),
                trailing: _message == null
                    ? null
                    : _message!.read.isEmpty &&
                            _message!.fromId != APIs.user.uid
                        ? Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                                color: Colors.greenAccent.shade400,
                                borderRadius: BorderRadius.circular(10)),
                          )
                        : Text(
                            // _message!.sent,
                            MyDateUtils.getLastMessageTime(
                                context: context, time: _message!.sent),
                            style: const TextStyle(color: Colors.black54),
                          ),
              );
            }),
      ),
    );
  }
}
