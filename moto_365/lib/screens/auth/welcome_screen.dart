import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:moto_365/screens/auth/login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.deepOrangeAccent : Colors.white38,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            color: Color(0xFF121212),
            child: PageView(
              physics: ClampingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: <Widget>[
                Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Image(
                        image: AssetImage(
                          'assets/images/onboarding1.png',
                        ),
                        height: MediaQuery.of(context).size.height*0.75,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:20.0),
                      child: Text(
                        'Book\nServices',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    Padding(
                     padding: const EdgeInsets.symmetric(horizontal:20.0),
                      child: Text(
                        'Book services via our app',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            color: Colors.white60,
                            ),
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Image(
                        image: AssetImage(
                          'assets/images/onboarding2.png',
                        ),
                        height: MediaQuery.of(context).size.height*0.75,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:20.0),
                      child: Text(
                        'Car\nCommunities',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    Padding(
                     padding: const EdgeInsets.symmetric(horizontal:20.0),
                      child: Text(
                        'Be part of exclusive car communities',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            color: Colors.white60,
                            ),
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Image(
                        image: AssetImage(
                          'assets/images/onboarding3.png',
                        ),
                        height: MediaQuery.of(context).size.height*0.75,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:20.0),
                      child: Text(
                        'Car\nAccesories',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    Padding(
                     padding: const EdgeInsets.symmetric(horizontal:20.0),
                      child: Text(
                        'Find car accesories for your car',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            color: Colors.white60,
                            ),
                      ),
                    )
                  ],
                ),
                
              ],
            ),
          ),
          Positioned(
            top: 30,
            right: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:5.0,vertical:5),
              child: Container(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: () => Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName),
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            child: Row(
              children: <Widget>[
                Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 20,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical:10),
                child: _currentPage != _numPages - 1
                    ? Align(
                      alignment: FractionalOffset.bottomRight,
                      child: FlatButton(
                        onPressed: () {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Next',
                              style: TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 20.0,
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.deepOrange,
                              size: 20.0,
                            ),
                          ],
                        ),
                      ),
                    )
                    : Align(
                      alignment: FractionalOffset.bottomRight,
                      child: FlatButton(
                        onPressed: () => Navigator.of(context)
                            .pushReplacementNamed(LoginScreen.routeName),
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    )),
          ),
        ],
      )),
    );
  }
}
