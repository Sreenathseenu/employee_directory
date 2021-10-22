import 'package:flutter/material.dart';
import 'package:moto_365/components/background.dart';
import 'package:moto_365/screens/cart/cart_screen.dart';
import 'package:moto_365/screens/chat/chat_list_screen.dart';
import 'package:moto_365/screens/forum/club_main_screen.dart';
import 'package:moto_365/screens/forum/forum_screen.dart';
import 'package:moto_365/screens/home/drawer.dart';
import 'package:moto_365/screens/home/home_screen.dart';
import 'package:moto_365/screens/home/set_location.dart';
import 'package:moto_365/screens/map/map_screen.dart';
import 'package:moto_365/screens/search/search_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final List<Widget> _children = [
    HomeScreen(),
    SearchScreen(),
    Map(),
    CartScreen(),
    ClubMain(),
  ];

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
          /* appBar:  AppBar(
          
          
          title:_title[_selectedIndex],
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right:12.0),
              child: SizedBox(width:70,child: Image(image: AssetImage('assets/images/slice.png'))),
            )
          ],
        ),
        drawer: DrawerWidget(),*/
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).bottomAppBarTheme.color,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.deepOrange,
            unselectedItemColor: Colors.white,
            unselectedFontSize: 10.0,
            selectedFontSize: 10.0,
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            currentIndex: _selectedIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    OMIcons.home,
                    size: 24,
                  ),
                  title: Text('',
                      style: TextStyle(
                        fontSize: 0.0,
                      ))),
              BottomNavigationBarItem(
                  icon: Icon(
                    OMIcons.search,
                    size: 24,
                  ),
                  title: Text('',
                      style: TextStyle(
                        fontSize: 0.0,
                      ))),
              BottomNavigationBarItem(
                  icon: Icon(
                    OMIcons.map,
                    size: 24,
                  ),
                  title: Text('',
                      style: TextStyle(
                        fontSize: 0.0,
                      ))),
              BottomNavigationBarItem(
                  icon: Icon(
                    OMIcons.shoppingCart,
                    size: 24,
                  ),
                  title: Text('',
                      style: TextStyle(
                        fontSize: 0.0,
                      ))),
              BottomNavigationBarItem(
                  icon: Icon(
                    OMIcons.message,
                    size: 24,
                  ),
                  title: Text('',
                      style: TextStyle(
                        fontSize: 0.0,
                      ))),
            ],
          ),
          body: _children[_selectedIndex]),
    );
  }
}
