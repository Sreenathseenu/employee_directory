/*import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moto_365/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
class NewMessage extends StatefulWidget {
  final int index;
  NewMessage({Key key, this.index}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final channel = IOWebSocketChannel.connect('ws://192.168.225.46:8000/ws/chat/test/');

  final controller = TextEditingController();
  var _enteredMessage = '';
  void _sendMessage() {
    FocusScope.of(context).unfocus();
   if (controller.text.isNotEmpty) {
     channel.sink.add(
       json.encode({"message":controller.text})
       );
    }
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Auth>(context).customer;
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
              child: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: 'Write something...',
            fillColor: Colors.grey[900],
            filled: true
            ),
            onChanged: (value) {
              setState(() {
                _enteredMessage = value;
              });
            },
          )),
          IconButton(
              icon: Icon(Icons.send, color: Colors.deepOrange,),
              onPressed: _enteredMessage.trim().isEmpty
                  ? null
                  : () {
                      _sendMessage();
                    })
        ],
      ),
    );
  }
}*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moto_365/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class NewMessage extends StatefulWidget {
  final int index;
  NewMessage({Key key, this.index}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final controller = TextEditingController();
  var _enteredMessage = '';
  void _sendMessage(id, name) {
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance
        .collection('chats/hkbsyyOPuAwAmxTIMxex/${widget.index}')
        
    .add({'text': _enteredMessage, 'created': Timestamp.now(), 'user': id,'username':name});
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Auth>(context).customer;
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
              child: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: 'Write something...',
            fillColor: Colors.grey[900],
            filled: true
            ),
            onChanged: (value) {
              setState(() {
                _enteredMessage = value;
              });
            },
          )),
          IconButton(
              icon: Icon(Icons.send, color: Colors.deepOrange,),
              onPressed: _enteredMessage.trim().isEmpty
                  ? null
                  : () {
                      _sendMessage(data['id'], data['name']);
                    })
        ],
      ),
    );
  }
}

