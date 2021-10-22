import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:moto_365/components/button.dart';
import 'package:moto_365/components/gard.dart';
import 'package:moto_365/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class MySample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MySampleState();
  }
}

class MySampleState extends State<MySample> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Cart>(context);
    return Grad(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('Payment'),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    // Expanded(
                    //child: SingleChildScrollView(
                    //child:
                    CreditCardForm(
                      onCreditCardModelChange: onCreditCardModelChange,
                      textColor: Colors.white,
                      themeColor: Colors.white,
                    ),
                    //),
                    // ),

                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: _isLoading
                          ? Center(child: CircularProgressIndicator())
                          : Button(
                              onPress: () {
                                data.placeOrder().then((_) {
                                  print('done');
                                  Provider.of<Cart>(context, listen: false)
                                      .fetchCart()
                                      .then((value) {
                                    _isLoading = false;
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  });
                                });
                                setState(() {
                                  _isLoading = true;
                                });
                              },
                              text: 'CONFIRM',
                            ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
