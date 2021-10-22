import 'package:flutter/material.dart';

class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute({
    WidgetBuilder builder,
    RouteSettings settings,
  }) : super(
          builder: builder,
          settings: settings,
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    Animation<Offset> custom=Tween<Offset>(begin: Offset(1.0,0.0),end: Offset(0.0,0.0)).animate(animation);
    /*if (settings.) {
      return child;
    }*/
    return SlideTransition(
      position: custom,
      child: child,

    );
  }
}

class CustomPageTransitionBuilder extends PageTransitionsBuilder {
 @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
   Animation<Offset> custom=Tween<Offset>(
     
     begin: Offset(1.0,0.0),end: Offset(0.0,0.0)).animate(animation);
    /*if (settings.) {
      return child;
    }*/
    return SlideTransition(
      position: custom,
      child: child,
      
    );
  }
}
