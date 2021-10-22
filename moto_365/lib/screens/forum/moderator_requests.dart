import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moto_365/components/gard.dart';
import 'package:moto_365/providers/club_provider.dart';
import 'package:provider/provider.dart';

class Requests extends StatefulWidget {
  Requests({Key key}) : super(key: key);

  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  bool _isInit = true;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      Provider.of<ClubProvider>(context)
          .getUserrequest()
          .then((value) => _isLoading = false);
    }
    _isInit=false;
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ClubProvider>(context);
    return Grad(
          child: Scaffold(
          //backgroundColor: Colors.grey[900],
          appBar: AppBar(title: Text('Requests')),
          body:_isLoading?Center(child:SpinKitSpinningLines(
  color: Colors.deepOrange,
  size: 50.0,
)):data.requests==null||data.requests.isEmpty?Center(child:Text('no requests')):
           Center(
             child: ListView.separated(
                itemBuilder: (context,index){
                  return Center(
                    child: Container(
                      child:Center(
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                          Text(data.requests[index]['user'],style:TextStyle(
                            fontSize: 14,
                            color:Colors.white70
                          )),
                          FlatButton(onPressed: (){
                            
                              
                              data.denyRequest(data.requests[index]['id'], data.requests[index]['user']).then((_){
                              setState(() {
                                
                                
                                 _isInit=true;
                              });
                            
                            
                             
                              } );
                          }, child: Icon(Icons.close,color:Colors.red)),

                          FlatButton(onPressed: (){
                            
                              
                              data.acceptRequest(data.requests[index]['id'], data.requests[index]['user']).then((_){
                              setState(() {
                                
                                
                                 _isInit=true;
                              });
                        
                            
                             
                              } );
                          }, child: Icon(Icons.check,color:Colors.green))
                        ],)
                      )
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Container(
                      height: 1, width: double.infinity, color: Colors.white38);
                },
                itemCount: data.requests.length),
           )),
    );
  }
}
