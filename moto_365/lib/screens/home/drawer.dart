import 'package:flutter/material.dart';
import 'package:moto_365/providers/auth_provider.dart';
import 'package:moto_365/screens/forum/club_home.dart';
import 'package:moto_365/screens/forum/club_main_screen.dart';
import 'package:moto_365/screens/forum/forum_home.dart';
import 'package:moto_365/screens/forum/forum_list.dart';
import 'package:moto_365/screens/forum/thread_create.dart';
import 'package:moto_365/screens/home/general.dart';

import 'package:moto_365/screens/home/profile_settings.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  /* @override
  void didChangeDependencies() {
    Provider.of<Auth>(context).getCustomer();
    super.didChangeDependencies();
  }*/
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Auth>(context);
    print(data.vehicles);

    List<DropdownMenuItem> items = [];
    for (int i = 0; i < data.vehicles.length; i++) {
      items.add(DropdownMenuItem(
        child: Text(
            "${data.vehicles[i]['vehicle_brand']}, ${data.vehicles[i]['vehicle_model']}"),
        value: data.vehicles[i]['id'],
      ));
    }
    return Container(
      color: Color(0xff1e1e1e),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.75,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 50),
          color: Color(0xff1e1e1e),
          child: !data.isAuth
              ? Center(
                  child: ListTile(
                    onTap: () {
                      Provider.of<Auth>(context, listen: false).logOut();
    
                      Navigator.of(context).pushReplacementNamed('/');
                    },
                    title: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.deepOrange,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                )
              :
              //data.customer==null||data.customer.isEmpty?Center(child:CircularProgressIndicator()):
              SingleChildScrollView(
                child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: data.customer['photo'] == null ||
                                data.customer['photo'] == ""
                            ? AssetImage('assets/images/slice.png')
                            : NetworkImage(data.customer['photo']),
                      ),
                      SizedBox(height: 20),
                      Text(
                        data.customer['name'] ?? "",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        color: Colors.deepOrange,
                        height: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Set Vehicle',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  backgroundColor: Colors.transparent,
                                  color: Colors.white70),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.60,
                            decoration: BoxDecoration(
                              color: Theme.of(context).dialogTheme.backgroundColor,
                              border: Border.all(
                                width: 1,
                                color:
                                    Theme.of(context).dialogTheme.backgroundColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            margin:
                                EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Center(
                              child: DropdownButton(
                                  hint: Text('vehicles'),
                                  value: data.activeVehicle['id'],
                                  onChanged: (value) {
                                    int index = data.vehicles
                                        .indexWhere((item) => item['id'] == value);
                                    data.setActiveVehicle(data.vehicles[index]);
                                  },
                                  underline: Container(
                                    height: 0.0,
                                  ),
                                  items: items),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        color: Colors.deepOrange,
                        height: 1,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                        decoration: BoxDecoration(
                            //color:Colors.grey[800],
                            borderRadius: BorderRadius.circular(8)),
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder:(context)=> General()));
                          },
                          title: Text(
                            'Profile',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                backgroundColor: Colors.transparent,
                                color: Colors.white70),
                          ),
                          leading: Icon(
                            Icons.account_circle,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                        decoration: BoxDecoration(
                            //color:Colors.grey[800],
                            borderRadius: BorderRadius.circular(8)),
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).pop();
                           // Navigator.of(context).pushNamed(ForumList.routeName);
                          },
                          title: Text(
                            'Reward',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                backgroundColor: Colors.transparent,
                                color: Colors.white70),
                          ),
                          leading: Icon(Icons.card_giftcard),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                        decoration: BoxDecoration(
                            //color:Colors.grey[800],
                            borderRadius: BorderRadius.circular(8)),
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).pop();
                           // Navigator.of(context).pushNamed(ForumList.routeName);
                          },
                          title: Text(
                            'Help & About',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                backgroundColor: Colors.transparent,
                                color: Colors.white70),
                          ),
                          leading: Icon(Icons.info),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Provider.of<Auth>(context, listen: false).logOut();
              
                          Navigator.of(context).pushReplacementNamed('/');
                        },
                        title: Text(
                          'sign out',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.deepOrange,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text("v1.2 (BETA)",style: TextStyle(color:Colors.white12,))
                    ],
                  ),
              )),
    );
  }
}

/*pk.eyJ1Ijoic3JlZW5hdGgyMDk5IiwiYSI6ImNrN3I0bG4xdzBhbG4zZW12OGpjbGlodzQifQ.DLnMLN92Ipxgx8STc8LdCg*/
/*mapbox://styles/sreenath2099/ckamsvfb953uc1ilkt92eq8u9*/
/*mapbox://styles/sreenath2099/ckas2kguy0q2z1iqjbaf27fem*/
