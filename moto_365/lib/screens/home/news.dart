import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:moto_365/components/button.dart';
import 'package:moto_365/screens/home/news_expanded.dart';
import 'package:moto_365/screens/home/service_now_expanded.dart';



class News extends StatefulWidget {
  News({Key key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 188.0,
      height: 185.0,
      child: Container(
        height: 185.0,
        //margin: EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.grey[900],
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(0.0, 1.5),
              blurRadius: 1.5,
            )
          ], /*borderRadius: BorderRadius.circular(8),*/
        ),
        /*child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    child: Image(
                        image:
                            AssetImage('assets/images/BMW-X5-M-Competition.jpg'),
                        fit: BoxFit.cover,
                        height: 185,
                        width: 188)),*/
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('35',
                                  style: TextStyle(
                                      fontSize: 60,
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w700)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Days without service',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[400],
                                        fontFamily: 'Montserrat')),
                              ),
                                      Center(
                                        child: Button(
                      text:/* data.orders == null || data.orders == []
                        ?*/'SERVICE NOW',//:'DETAILS',
                      onPress: /* data.orders == null || data.orders == []
                        ?*/() {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ServiceNowExpanded()));
                      }//:(){},
                    ),
                                      )
                            ],
                          )
        ),
      ),
    );
  }
}

class NewsItem{
final String imgTitleSmall;
final String imgTitle;
final String img; 
final String title;
final String content;

NewsItem({this.imgTitle,this.content,this.img,this.title,this.imgTitleSmall});

}
