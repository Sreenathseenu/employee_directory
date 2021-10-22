import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moto_365/components/gard.dart';
import 'package:moto_365/providers/forum_provider.dart';
import 'package:moto_365/screens/forum/forum_list_subs.dart';
import 'package:provider/provider.dart';

class ForumList extends StatefulWidget {
  static const routeName='/forumlist';
  ForumList({Key key}) : super(key: key);

  @override
  _ForumListState createState() => _ForumListState();
}

class _ForumListState extends State<ForumList> {
  @override
  void initState() {
    
    super.initState();
    Provider.of<ForumProvider>(context,listen: false).fetchMaster();
    Provider.of<ForumProvider>(context,listen: false).fetchMasterWithSub();
  }
  @override
  Widget build(BuildContext context) {
   final data= Provider.of<ForumProvider>(context);
   
    return Grad(
          child: Scaffold(
        //backgroundColor: Colors.grey[900],
        appBar: AppBar(title:Text('FORUM')),
 body:data.isLoadingMasterWithSub?Center(child:SpinKitSpinningLines(
  color: Colors.deepOrange,
  size: 50.0,
)):ListView.builder(
      itemCount: data.masterWithSub.length,
      itemBuilder: (BuildContext context, int index) {
       
      return Container(
        child:Column(children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 4),
            color: Colors.grey[800],
            child: Text(
              
              data.masterWithSub[index]['name'],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
                color:Colors.white70
              ),
            )
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:(data.masterWithSub[index]['sub_forums']as List<dynamic>).map((item){
              return FlatButton(
                onPressed: (){
                  Navigator.of(context).pushNamed(Threads.routeName, arguments: item['id']);
                },
                child: Column(
                  children: <Widget>[
                    Text(item['title'],style: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                color:Colors.white54
              ),),
              SizedBox(height:10),
              Container(
                height:1,width:double.infinity,
                color:Colors.white38
              )
                  ],
                ),
              );
            }).toList()
          )
        ],)
      );
   },
  ),
      ),
    );
  }
}