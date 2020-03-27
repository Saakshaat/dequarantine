import 'package:DribbleUI/UI/button.dart';
import 'package:DribbleUI/UI/event_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


class Discover extends StatefulWidget {
  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  List<Widget> eventsList = <Widget>[
    EventCard(
      dayDate: "08",
      monthDate: "Jun",
      title: "Wine testing",
      categories: "Wine & Design",
      time: "07:30 PM - 09:00 PM",
    ),
    EventCard(
      dayDate: "24",
      monthDate: "May",
      title: "Noodles testing",
      categories: "Noodle & nutrition",
      time: "07:30 PM - 09:00 PM",
    ),
  ];

  EdgeInsets defaultPadding = EdgeInsets.symmetric(horizontal: 12);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      // padding: EdgeInsets.symmetric(horizontal: 12),
      child: ListView(
        children: <Widget>[
          Container(
            padding: defaultPadding,
            child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.search,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search for",
                      border: InputBorder.none
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.swap_horizontal_circle,
                    color: Theme.of(context).primaryColor
                  ),
                ),
              ],
            ),
          ),

          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CategoryButton(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                icon: Icons.fastfood,
                text: "Food",
              ),
              CategoryButton(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                icon: Icons.music_note,
                text: "Music",
              ),
              CategoryButton(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                icon: Icons.color_lens,
                text: "Art",
              ),
            ],
          ),

          Container(
            padding: defaultPadding,
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Popular", style: Theme.of(context).textTheme.headline1),
                GestureDetector(
                  onTap: () => print("view all"),
                  child: Text("View All", style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).primaryColor,
                  )),
                ),
              ],
            ),
          ),
                
          CarouselSlider(
            height: 340,
            items: eventsList,
            viewportFraction: 0.9,
            initialPage: 0,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            pauseAutoPlayOnTouch: Duration(seconds: 5),
            scrollDirection: Axis.horizontal,
            // enlargeCenterPage: true
          ),
          Container(
            padding: defaultPadding,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("This Weekend", style: Theme.of(context).textTheme.headline1),
            ),
          ),
          eventsList[0]
        ],
      ),
    );
  }
}