/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moto_365/components/gard.dart';
import 'package:moto_365/providers/club_provider.dart';
import 'package:moto_365/screens/chat/messages.dart';
import 'package:moto_365/screens/chat/new_message.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  final int index;
  final String title;

  const ChatScreen({Key key, this.index, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ClubProvider>(context);

    return Grad(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            title,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: Container(
            child: Column(
          children: <Widget>[
            Expanded(
                child: Messages(
              ind: index,
            )),
            NewMessage(
              index: index,
            )
          ],
        )),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moto_365/components/gard.dart';
import 'package:moto_365/providers/club_provider.dart';
import 'package:moto_365/screens/chat/messages.dart';
import 'package:moto_365/screens/chat/new_message.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  final int index;
  final String title;

  const ChatScreen({Key key, this.index, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ClubProvider>(context);

    return Grad(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            title,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: Container(
            child: Column(
          children: <Widget>[
            Expanded(
                child: Messages(
              ind: index,
            )),
            NewMessage(
              index: index,
            )
          ],
        )),
      ),
    );
  }
}
