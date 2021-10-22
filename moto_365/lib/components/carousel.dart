import 'package:flutter/material.dart';
import 'package:moto_365/screens/forum/youtube.dart';

class Carousel extends StatelessWidget {
  Carousel({this.pageController, this.images, this.height, this.vidUrl});

  final PageController pageController;
  final List images;
  final double height;
  final String vidUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: PageView.builder(
          controller: pageController,
          itemCount: images.length + 1,
          itemBuilder: (BuildContext context, int index) {
            return AnimatedBuilder(
              animation: pageController,
              builder: (BuildContext context, Widget widget) {
                double value = 1;
                // if (pageController.position.haveDimensions) {
                //   value = pageController.page - index;
                //   value = (1 - (value.abs() * 0.15)).clamp(0.0, 1.0);
                // }
                return Center(
                  child: SizedBox(
                      height: Curves.easeIn.transform(value) * height,
                      child: widget),
                );
              },
              child: index == images.length
                  ?vidUrl==""||vidUrl == null?Container(): Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10)),
                      child: Youtube(
                        url: vidUrl,
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(
                          image: NetworkImage(images[index]),
                          //AssetImage('assets/images/slice.png'),
                          fit: BoxFit.cover,
                        ),
                      )),
            );
          }),
    );
  }
}
/*PageController _pageController;

  @override
  void initState() {
    
    super.initState();
    _pageController=PageController(initialPage: 0, viewportFraction: 0.8);
  }*/