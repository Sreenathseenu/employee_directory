
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:moto_365/components/custom_route.dart';
import 'package:moto_365/providers/auth_provider.dart';
import 'package:moto_365/screens/auth/image_upload.dart';
import 'package:moto_365/screens/auth/login_screen.dart';
import 'package:moto_365/screens/auth/otp_screen.dart';
import 'package:moto_365/screens/auth/profile_details.dart';
import 'package:moto_365/screens/auth/vehicle_add.dart';
import 'package:moto_365/screens/auth/welcome_screen.dart';
import 'package:moto_365/screens/cart/check_out.dart';
import 'package:moto_365/screens/forum/club_home.dart';
import 'package:moto_365/screens/forum/forum_expanded.dart';
import 'package:moto_365/screens/forum/forum_list.dart';
import 'package:moto_365/screens/forum/forum_list_subs.dart';
import 'package:moto_365/screens/forum/thread_create.dart';
import 'package:moto_365/screens/home/home.dart';
import 'package:moto_365/screens/home/profile_settings.dart';
import 'package:moto_365/screens/home/set_location.dart';
import 'package:moto_365/screens/search/products_expanded.dart';
import 'package:moto_365/screens/search/services_expanded.dart';
import 'package:moto_365/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class MainApp extends StatelessWidget {
  const MainApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//     AwesomeNotifications().actionStream.listen(
//     (ReceivedNotification receivedNotification){

//         Navigator.of(context).pushNamed(
//             '/NotificationPage',
//             arguments: {
//                 // your page params. I recommend you to pass the
//                 // entire *receivedNotification* object
//                 receivedNotification
//             }
//         );

//     }
// );
    return Consumer<Auth>(builder: (ctx, auth, _) {
      return /*Platform.isIOS
          ? CupertinoApp(
              debugShowCheckedModeBanner: false,
              title: 'MOTO365',
              
              theme: CupertinoThemeData(
                scaffoldBackgroundColor: Colors.transparent,
                brightness: Brightness.light,
               primaryColor: Color(0xFFFF5B22),
               textTheme: CupertinoTextThemeData(
                 actionTextStyle: TextStyle(
                  
                      color:Colors.black,
                 ),
                 textStyle:  TextStyle(
                      color:Color.fromRGBO(0, 0, 0, 0.87),
                    ), 
                    tabLabelTextStyle: TextStyle(
                      color:Color.fromRGBO(0, 0, 0, 0.6),
                    ),
               ),
               barBackgroundColor: Colors.white24,
               primaryContrastingColor: Colors.deepOrange
              ),
              
            )
          :*/ MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'MOTO365',
              themeMode: ThemeMode.dark,
              theme: ThemeData(
                
                brightness: Brightness.light,
                backgroundColor: Colors.grey[100],
                primaryColor: Color(0xFFFF5B22),
                accentColor: Colors.deepOrange,
                canvasColor: Colors.white,
                primarySwatch: Colors.deepOrange,
                bottomAppBarTheme: BottomAppBarTheme(
                  color: Colors.grey[150],
                ),
                fontFamily: 'Montserrat',
                scaffoldBackgroundColor: Colors.transparent,
                textTheme: TextTheme(
                  
                    bodyText2: TextStyle(
                      color:Colors.black,
                    ),
                     bodyText1: TextStyle(
                      color:Color.fromRGBO(0, 0, 0, 0.6),
                      backgroundColor:  Color.fromRGBO(0, 0, 0, 0.28)
                    ),
                    headline1: TextStyle(
                      fontFamily: 'Praktika',
                      fontSize: 14,
                      color: Color.fromRGBO(0, 0,0, 0.87),
                      letterSpacing: -0.5,
                    ),
                    subtitle1: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 10,
                      color: Color.fromRGBO(0, 0, 0, 0.87),
                      letterSpacing: 0.75,
                    )),
                appBarTheme: AppBarTheme(
                  color: Colors.transparent,
                  elevation: 0.0,
                  textTheme: TextTheme(
                    headline1: TextStyle(
                      fontFamily: 'Praktika',
                      fontSize: 24,
                      color: Color.fromRGBO(0, 0, 0, 0.87),
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                accentColorBrightness: Brightness.dark,
                dialogTheme: DialogTheme(
                  backgroundColor: Colors.grey[300],
                  contentTextStyle: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.87),
                    fontFamily: 'Monteserrat',
                  )
                ),
                dividerColor: Colors.grey[900],
                errorColor: Colors.red,
                
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                pageTransitionsTheme: PageTransitionsTheme(
                  builders: {
                    TargetPlatform.android: CustomPageTransitionBuilder(),
                    TargetPlatform.iOS: CustomPageTransitionBuilder(),
                  },
                ),
                backgroundColor: const Color(0xff121212),
                canvasColor: const Color(0xff121212),
                primaryColor: Color(0xFFFF5B22),
                accentColor: Colors.deepOrangeAccent,
                bottomAppBarTheme: BottomAppBarTheme(
                  color:Colors.grey[920],
                ),
                scaffoldBackgroundColor: Colors.transparent,
                textTheme: TextTheme(
                  
                    bodyText2: TextStyle(
                      
                      color:Colors.white,
                    ),
                     bodyText1: TextStyle(
                      color:Color.fromRGBO(255, 255, 255, 0.6),
                      backgroundColor: Color.fromRGBO(255, 255, 255, 0.28)
                    ),
                    headline1: TextStyle(
                      fontFamily: 'Praktika',
                      fontSize: 14,
                      color: Color.fromRGBO(255, 255, 255, 0.87),
                      letterSpacing: -0.5,
                    ),
                    subtitle1: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      color: Color.fromRGBO(255, 255, 255, 0.87),
                      letterSpacing: 0.75,
                    ),
                  
                    ),
                appBarTheme: AppBarTheme(
                  color: Colors.transparent,//Color.fromRGBO(50, 50, 50, 0.25),
                  elevation: 0.0,
                  textTheme: TextTheme(
                    headline1: TextStyle(
                      fontFamily: 'Praktika',
                      
                      fontSize: 24,
                      color: Color.fromRGBO(255, 255, 255, 0.87),
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                accentColorBrightness: Brightness.dark,
                dialogTheme: DialogTheme(
                  backgroundColor: Colors.grey[800],
                  contentTextStyle: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.87),
                    fontFamily: 'Monteserrat',
                  )
                ),
                dividerColor: Colors.grey[900],
                errorColor: Colors.red,

              ),
            home: auth.isAuth?Home():
           FutureBuilder(
             future: auth.autoLogin(),
             builder: (ctx,authSnapshot)=>
            authSnapshot.connectionState==ConnectionState.waiting?SplashScreen():auth.isAuth?Home(): WelcomeScreen(),
            ),
            routes: {
              OtpScreen.routeName:(ctx)=>OtpScreen(),
              LoginScreen.routeName:(ctx)=>LoginScreen(),
              ProfileDetails.routeName:(ctx)=>ProfileDetails(),
              ImageUpload.routeName:(ctx)=>ImageUpload(),
              VehicleAdd.routeName:(ctx)=>VehicleAdd(),
              ServicesExpanded.routeName:(ctx)=>ServicesExpanded(),
              ProductsExpanded.routeName:(ctx)=>ProductsExpanded(),
              LocationInput.routeName:(ctx)=>LocationInput(),
              Profile.routeName:(ctx)=>Profile(),
              CheckOut.routeName:(ctx)=>CheckOut(),
              ForumList.routeName:(ctx)=>ForumList(),
              Threads.routeName:(ctx)=>Threads(),
              //ForumExpanded.routeName:(ctx)=>ForumExpanded(),
              //ThreadAdd.routeName:(ctx)=>ThreadAdd(),
            
             
            },
            );
    });
  }
}
