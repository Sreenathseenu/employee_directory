import 'package:flutter/material.dart';
import 'package:moto_365/components/gard.dart';
import 'package:moto_365/providers/auth_provider.dart';
import 'package:moto_365/screens/home/general.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  static const routeName='/profile';
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final data=Provider.of<Auth>(context);
    return Grad(
          child: Scaffold(
        //backgroundColor: Colors.grey[900],
        appBar: AppBar(
         
          title: Text('PROFILE'),

        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child:ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text( data.customer['name']??"",
                    style:TextStyle(
                      fontSize:18,
                      fontFamily:'Montserrat',
                      fontWeight:FontWeight.w600,
                      color:Color.fromRGBO(255,255,255,0.87),
                    )
                    ),
                    
                    Text(data.customer['name'],
                    style:TextStyle(
                      fontSize:12,
                      fontFamily:'Montserrat',
                      fontWeight:FontWeight.w400,
                      color:Color.fromRGBO(255,255,255,0.6),
                    )
                    ),
                   
                  ],
                ),
                Container(
                   padding: EdgeInsets.all(8),
                       decoration: BoxDecoration(
                         shape: BoxShape.circle,
                         border:Border.all(color:Colors.deepOrange,)
                       ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:data.customer['photo']==null||data.customer['photo'].isEmpty?AssetImage('assets/images/slice.png'):NetworkImage(data.customer['photo']) 
                    
                  ),
                )
              ],),
            
            ),
            Container(
              
              height:1,
              color:Color.fromRGBO(255,255,255,0.6)
            ),
            GestureDetector(
              onTap: (){
                
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>General()));
              },
                        child: Container(
                padding: EdgeInsets.only(top:18,left: 8),
                height:55,
                margin: EdgeInsets.only(top:16,
                bottom:4,
                
                ),
                decoration: BoxDecoration(
                        color: Color.fromRGBO(255,255,255,0.16),
                        borderRadius: BorderRadius.circular(8)
                      ),
                child: Text('General',
                      textAlign: TextAlign.start,
                      style:TextStyle(
                        fontSize:14,
                                              fontFamily:'Montserrat',
                                              fontWeight:FontWeight.w600,
                      color:Color.fromRGBO(255,255,255,0.87),

                      )
                      ),
              ),
            ),
           
            Container(
              padding: EdgeInsets.only(top:18,left: 8),
              height:55,
              margin: EdgeInsets.only(top:4,
              bottom:4,
              
              ),
              decoration: BoxDecoration(
                      color: Color.fromRGBO(255,255,255,0.16),
                      borderRadius: BorderRadius.circular(8)
                    ),
              child: Text('Rewards',
                    style:TextStyle(
                      fontSize:14,
                      fontFamily:'Montserrat',
                      fontWeight:FontWeight.w600,
                      color:Color.fromRGBO(255,255,255,0.87),
                    )
                    ),
            ),
            Container(
              padding: EdgeInsets.only(top:18,left: 8),
              height:55,
              margin: EdgeInsets.only(top:4,
              bottom:4,
              
              ),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255,255,255,0.16),
                      
                      borderRadius: BorderRadius.circular(8)
                    ),
              child: Text('Help & About',
                    style:TextStyle(
                      fontSize:14,
                      fontFamily:'Montserrat',
                      fontWeight:FontWeight.w600,
                      color:Color.fromRGBO(255,255,255,0.87),
                    )
                    ),
            ),
            SizedBox(
              height:20
            ),
            Container(
              child: FlatButton(onPressed: (){
                Provider.of<Auth>(context, listen: false).logOut();
                           
          Navigator.of(context).pushReplacementNamed('/');
              }, child: (Text('Logout',
              textAlign: TextAlign.start,
                      style:TextStyle(
                        
                        fontSize:14,
                        fontFamily:'Montserrat',
                        fontWeight:FontWeight.w600,
                        color:Color(0xFFF05C2D),
                      )
                      ))),
            )
          ],
          
        ),),
        

      ),
    );
  }
}