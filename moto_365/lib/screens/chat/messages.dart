/*import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moto_365/screens/chat/bubble.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Messages extends StatelessWidget {
  final int ind;
  Messages({Key key, this.ind}) : super(key: key);
  final channel =
      IOWebSocketChannel.connect('ws://192.168.225.46:8000/ws/chat/test/');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: channel.stream,
        builder: (ctx, streamSnapshot) {
          final docs = streamSnapshot.data;
          final data = json.decode(docs);
          print(docs);
          //print(docs.length);
          return Container(
            height: 400,
            child: ListView.builder(
                reverse: true,
                itemCount: 3,
                itemBuilder: (ctx, index) {
                  print(docs);
                  return Container(
                    padding: EdgeInsets.all(8),
                    child: Bubble(data == null ? 'hello' : data['message'], 2,
                        'sreenath', Timestamp.now()),
                  );
                }),
          );
        });
  }
}*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:moto_365/screens/chat/bubble.dart';

class Messages extends StatelessWidget {
  final ind;
  const Messages({Key key, this.ind}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("\n\nnind :: $ind\n\n");
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/hkbsyyOPuAwAmxTIMxex/$ind')
            .orderBy('created', descending: true)
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            print('waiting');
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final docs = streamSnapshot.data.documents;
          print(docs[0]['text']);
           print(docs[0]['username']);
            print(docs[0]['created']);
             print(docs[0]['user']);
          print(docs.length);
          return Container(
            height: 400,
            child: ListView.builder(
                reverse: true,
                itemCount: docs.length,
                itemBuilder: (ctx, index) => Container(
                      padding: EdgeInsets.all(8),
                      child: Bubble(docs[index]['text'], docs[index]['user'],
                          docs[index]['username'], docs[index]['created']),
                    )),
          );
        });
  }
}
