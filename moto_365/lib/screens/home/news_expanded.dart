import 'package:flutter/material.dart';
import 'package:moto_365/components/gard.dart';
import 'package:moto_365/screens/home/news.dart';



class NewsExpanded extends StatelessWidget {
  final int index;

  NewsExpanded(this.index);

  final List<NewsItem> newsItems = [
    NewsItem(
        imgTitle: 'assets/images/news/Group259news_.png',
        imgTitleSmall: 'assets/images/news/Group297.png',
        img: 'assets/images/news/carousal_BMW-X5-M-Competition.jpg',
        title: '2020 BMW  X5 M Competition review,test drive',
        content: 'We\'ve driven the latest iteration of the BMW X5 M Competition to find out what to expect when this 625hp performance Suv arrives in the Indian market.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
    NewsItem(
      imgTitle: 'assets/images/news/Group293news_.png',
      imgTitleSmall: 'assets/images/news/Group301.png',
      img: 'assets/images/news/carousal_20200316083436_BS6-Renault-Duster.jpg',
      title: 'Renault Duster BS6 priced from Rs 8.49 lakh',
      content: 'Duster BS6 comes with a sole 1.5-litre petrol engine; three varient on offer.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
    NewsItem(
      imgTitle: 'assets/images/news/Group294news_.png',
      imgTitleSmall: 'assets/images/news/Group299.png',
      img: 'assets/images/news/carousal_3235df453786c9b5dd6c52b28acd102e.jpg',
      title: 'Skoda Karoq bookings open ahead of launch',
      content: 'Deliveries of the Skoda Kaorq will begin in India starting May 6, 2020; only the 150 hp, 1.5-litre TSI engine mated to 7-speed DSG automatic will be offered in India.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
    ),


    
  ];

  @override
  Widget build(BuildContext context) {
    return Grad(
          child: Scaffold(
        appBar: AppBar(
          title:Text('news')
        ),
        body: SafeArea(
          child:ListView(
            children: <Widget>[
              Container(
                height: 250,
                width: double.infinity,
                child: Image(image: AssetImage(newsItems[index].img),fit:BoxFit.cover),
              ),
              Text(newsItems[index].title,style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white70,
              ),),
              SizedBox(height:20),
              Text(newsItems[index].content,style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 12,
                
                color: Colors.white70,
              ),),
            ],
          )
        ),
      ),
    );
  }
}
