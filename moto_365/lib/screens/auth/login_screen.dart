import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:moto_365/components/background.dart';
import 'package:moto_365/components/button.dart';
import 'package:moto_365/components/outline_button.dart';
import 'package:moto_365/providers/auth_provider.dart';
import 'package:moto_365/screens/auth/otp_screen.dart';
import 'package:moto_365/screens/auth/profile_details.dart';
import 'package:moto_365/screens/home/home.dart';
import 'package:moto_365/screens/splash_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);
  static const routeName = '/auth/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  final _form = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  String code = '+91';
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      // Provider.of<Auth>(context).fetchCustomer();
      // Provider.of<Auth>(context).fetchVehicles();
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Auth>(context);
    void goToSignIn(phone) {
      data.getOtp(phone).then((_) {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pushNamed(OtpScreen.routeName, arguments: phone);
      }).catchError((onError) {
        setState(() {
          _isLoading = false;
        });
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('oops..'),
                  content: Text('$onError'),
                ));
      });
      if (mounted) {
        setState(() {
          _isLoading = true;
        });
      }
    }

    void goToSignUp(phone) {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context)
          .pushNamed(ProfileDetails.routeName, arguments: phone);
    }

    return Background(
        child:
        // data.isLoadingAuth
        //     ? SplashScreen()
        //     : 
        Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: AnimationLimiter(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 375),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                          children: <Widget>[
                            Center(
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(50, 80, 50, 10),
                                child: const Image(
                                  image: AssetImage(
                                    'assets/images/splash.png',
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            /* Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CountryPickerDropdown(
                      initialValue: 'in',
                      itemBuilder: (Country country) => Container(
                        child: /*Row(
                          children: <Widget>[
                            CountryPickerUtils.getDefaultFlagImage(country),
                            SizedBox(
                              width: 8.0,
                            ),*/
                            Text("+${country.phoneCode}(${country.isoCode})"),
                         /* ],
                        ),*/
                      ),
                      onValuePicked: (Country country) {
                        code = "+${country.phoneCode}";
                        print("${country.phoneCode}");
                      },
                    ),
                  ),*/
                            Form(
                              key: _form,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .dialogTheme
                                              .backgroundColor,
                                          border: Border.all(
                                            width: 1,
                                            color: Theme.of(context)
                                                .dialogTheme
                                                .backgroundColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 4),
                                        child: DropdownButton(
                                          underline: Container(
                                            height: 0.0,
                                          ),
                                          items: [
                                            DropdownMenuItem(
                                              child: Text('+91'),
                                              value: '+91',
                                            ),
                                            DropdownMenuItem(
                                              child: Text('+98'),
                                              value: '+98',
                                            )
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              code = value;
                                            });
                                          },
                                          value: code,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 3),
                                    Expanded(
                                      flex: 4,
                                      child: TextFormField(
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                            fillColor: Theme.of(context)
                                                .dialogTheme
                                                .backgroundColor,
                                            filled: true,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                  width: 0.0,
                                                  color: Theme.of(context)
                                                      .backgroundColor),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                  width: 0.0,
                                                  color: Theme.of(context)
                                                      .backgroundColor),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                  width: 0.0,
                                                  color: Theme.of(context)
                                                      .backgroundColor),
                                            ),
                                            hintText: 'Phone Number',
                                            hintStyle: TextStyle(fontSize: 12),
                                            prefixIcon: Icon(Icons.phone,
                                                size: 18,
                                                color:
                                                    Colors.deepOrangeAccent)),
                                        controller: phoneController,
                                        validator: (value) {
                                          if (value.isEmpty ||
                                              int.tryParse(value) == null) {
                                            return 'enter a valid phone number';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            _isLoading
                                ? SpinKitSpinningLines(
  color: Colors.deepOrange,
  size: 50.0,
)
                                : Button(
                                    onPress: () {
                                      final isValid =
                                          _form.currentState.validate();
                                      if (!isValid) {
                                        return;
                                      }
                                      final String phone = phoneController.text;
                                      print(phone);
                                      // data.isUserExist(phone)
                                      //     ?
                                      goToSignIn(phone);
                                      // : goToSignUp(phone);
                                    },
                                    text: 'SIGNIN',
                                  ),
                            Text("We'll send you a one time password",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Montserrat',
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .backgroundColor)),
                            // FlatButton(
                            //     onPressed: () {
                            //       Navigator.of(context).pushReplacement(
                            //           MaterialPageRoute(
                            //               builder: (context) => Home()));
                            //     },
                            //     child: Text(
                            //       'skip',
                            //       style: TextStyle(color: Colors.deepOrange),
                            //     ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ));
  }
}
