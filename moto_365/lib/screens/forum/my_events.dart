import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moto_365/providers/club_provider.dart';
import 'package:moto_365/screens/forum/club_expanded.dart';
import 'package:moto_365/screens/home/drawer.dart';
import 'package:provider/provider.dart';

class MyEvents extends StatefulWidget {
  
MyEvents({Key key}) : super(key: key);
  

  @override
  _MyEventsState createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
   bool _isLoading=true;

  
  bool _isInit=true;

  @override
  void didChangeDependencies() {
    
    super.didChangeDependencies();
    if(_isInit){
      Provider.of<ClubProvider>(context).checkModerator();
       Provider.of<ClubProvider>(context).fetchMyEvents().then((_) => _isLoading=false);
    }
   _isInit=false;
  }

  @override
  Widget build(BuildContext context) {
    final data=Provider.of<ClubProvider>(context);
   
     
    return Container(
      
      
      child:_isLoading? Center(child:SpinKitSpinningLines(
  color: Colors.deepOrange,
  size: 50.0,
)) :Container(
      
       child: data.myEvents==null||data.myEvents.isEmpty?Center(child: Text('No Items'),) : ListView.builder(
         itemCount: data.myEvents.length,
         itemBuilder: (context,index){
         return GestureDetector(
           onTap: (){
             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ClubExpanded(data.myEvents[index]['events_allowed']['id'],true)));
           },
                    child: Container(
             margin: EdgeInsets.symmetric(horizontal: 16,vertical: 5),
             padding: EdgeInsets.all(12),
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(8),
              // color:Colors.grey[800]
             ),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                  
                  Text(data.myEvents[index]['events_allowed']['user'],
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    

                  ),),
                  SizedBox(height:8),
                  
                  
                 Container(
                   //padding: EdgeInsets.all(4),
                   height: 400,
                   width:300,
                   decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                     color: Colors.grey[850],
                   ),
                   //width: double.infinity,
                  
                   child: ClipRRect(
                     borderRadius: BorderRadius.circular(10),
                     
                     child: Image(image: NetworkImage(data.myEvents[index]['events_allowed']['cover_image']), fit: BoxFit.cover,)),
                 ),
                
               ],
             ) ,
           ),
         );
       })),
    );
  }
}