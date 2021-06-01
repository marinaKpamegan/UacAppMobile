
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:uac_campus/utils/color_palette.dart';
import 'package:webfeed/webfeed.dart';


class RssFeedCarousel extends StatefulWidget {
  final RssFeed rssFeed;
  const RssFeedCarousel(this.rssFeed);
  @override
  _RssFeedCarouselState createState() => _RssFeedCarouselState();
}

class _RssFeedCarouselState extends State<RssFeedCarousel> {
  RssFeed feeds;
  int length = 1;
  @override
  void initState() {
    super.initState();
    if(widget.rssFeed.items != null){
      feeds = widget.rssFeed;
      length = feeds.items.length;
    }
  }
  @override
  Widget build(BuildContext context) {

    return Stack(
        children: [
          CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.95,
                aspectRatio: 2.0,
              ),
              items: List.generate(
                  length,
                      (i) => Center(
                    child:
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorPalette.blue.colorPalette,
                      ),
                      child: Container(
                        padding: EdgeInsets.only(left: 25, right: 25),
                        alignment: Alignment.center,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                feeds.items[i].title,
                                style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                softWrap: true,
                              ),
                              SizedBox(height: 5,),
                              Text(
                                reduceDescription(feeds.items[i].description),
                                style: TextStyle(color: Colors.white, fontSize: 12,),
                                softWrap: true,
                              ),
                              SizedBox(height: 10,),
                              InkWell(
                                child: Text(
                                  "Voir Plus >",
                                  style: TextStyle(color: Colors.white, fontSize: 14,backgroundColor: Color.fromRGBO(252, 95, 93, 1)),
                                  softWrap: true,
                                ),
                                onTap: (){},
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ))),
        ]
    );
  }

  String reduceDescription(String description){
    String newDesc = "";
    List splitDesc = [];
    if(description.length != 0){
      newDesc = description.replaceAll("&#160;", "");
      if(description.length > 60){
        splitDesc = description.split(" ");
        splitDesc = splitDesc.sublist(0, 25);
        print(splitDesc.toString());
        newDesc = splitDesc.join(" ") + "...";
        print(newDesc);
      }
    }
    return newDesc;
  }
}