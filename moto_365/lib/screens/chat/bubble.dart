/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moto_365/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class Bubble extends StatelessWidget {
  final String message;
  final String userName;
  final int id;
  final Timestamp time;
  Bubble(this.message, this.id, this.userName, this.time);
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Auth>(context).customer;
    bool _isMe = data['id'] == id ? true : false;
    print(id);
    print(id.runtimeType);
    print(data['id']);
    print(_isMe);
    print('${time.toDate().hour}:${time.toDate().minute}');
    return  Row(
      mainAxisAlignment:
          _isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: _isMe ? Color(0xff251814) : Colors.grey[900],
              borderRadius: _isMe
                  ? BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    )
                  : BorderRadius.only(
                      bottomRight: Radius.circular(12),
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
          width: 140,
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          margin: EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                userName,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: const Color(0xfffc5c2e),
                    //fontWeight: FontWeight.w600,
                    fontFamily: "Montserrat",
                    fontStyle: FontStyle.normal,
                    fontSize: 12.0),
              ),
              
              SizedBox(
                height: 8,
              ),
              Text(message,
               style: TextStyle(
    fontFamily: 'Montserrat',
    color: Color(0xffffffff),
    fontSize: 14,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    
    
    
    )
              ),
              SizedBox(
                height: 8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '${time.toDate().hour}:${time.toDate().minute}',
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                     style: TextStyle(
    fontFamily: 'Montserrat',
    color: Color(0x99ffffff),
    fontSize: 10,
    //fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    
    
    )
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moto_365/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class Bubble extends StatelessWidget {
  final String message;
  final String userName;
  final  id;
  final Timestamp time;
  Bubble(this.message, this.id, this.userName, this.time);
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Auth>(context).customer;
    bool _isMe = data['id'] == id ? true : false;
    print(id);
    print(id.runtimeType);
    print(data['id']);
    print(_isMe);
    print('${time.toDate().hour}:${time.toDate().minute}');
    return Row(
      mainAxisAlignment:
          _isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: _isMe ? Color(0xff251814) : Colors.grey[900],
              borderRadius: _isMe
                  ? BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    )
                  : BorderRadius.only(
                      bottomRight: Radius.circular(12),
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
          width: 140,
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          margin: EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                userName,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: const Color(0xfffc5c2e),
                    //fontWeight: FontWeight.w600,
                    fontFamily: "Montserrat",
                    fontStyle: FontStyle.normal,
                    fontSize: 12.0),
              ),
              
              SizedBox(
                height: 8,
              ),
              Text(message,
               style: TextStyle(
    fontFamily: 'Montserrat',
    color: Color(0xffffffff),
    fontSize: 14,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    
    
    
    )
              ),
              SizedBox(
                height: 8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '${time.toDate().hour}:${time.toDate().minute}',
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                     style: TextStyle(
    fontFamily: 'Montserrat',
    color: Color(0x99ffffff),
    fontSize: 10,
    //fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    
    
    )
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

