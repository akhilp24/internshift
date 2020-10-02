import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CategoriesHome extends StatefulWidget {
  @override
  _CategoriesHomeState createState() => _CategoriesHomeState();
}

class _CategoriesHomeState extends State<CategoriesHome> {
  CarouselController buttonCarouselController = CarouselController();
  @override
  // List items = [1, 2, 3, 4, 5];
  // final List<String> imgList = [
  //   'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  //   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  //   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  //   'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  //   'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  //   'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  // ];
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Stack(
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 1 / 1.1,
              height: 550,
              decoration: BoxDecoration(
                color: Color(0xffFAFAFA),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5,
                      spreadRadius: 0,
                      offset: Offset(0, 4),
                      color: Colors.grey[400]),
                ],
              ),
            ),
          ),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 50),
              child: Text(
                'Categories For You',
                style: TextStyle(
                    color: Color(0xff858585), fontWeight: FontWeight.bold),
              ),
            ),
            // Padding(
            //     padding: const EdgeInsets.only(top: 25.0, left: 20, right: 20),
            //     child: CarouselSlider.builder(
            //       options: CarouselOptions(height: 400),
            //       itemCount: (imgList.length / 2).round(),
            //       itemBuilder: (context, index) {
            //         final int first = index * 2;
            //         final int second = first + 1;
            //         return Row(
            //           children: [first, second].map((idx) {
            //             return Container(
            //               decoration: BoxDecoration(color: Colors.white),
            //               child: Image.network('idx'),
            //             );
            //           }).toList(),
            //         );
            //       },
            //     ))
          ])
        ],
      ),
    );
  }
}

class SavedScreenCard extends StatefulWidget {
  @override
  _SavedScreenCardState createState() => _SavedScreenCardState();
}

class _SavedScreenCardState extends State<SavedScreenCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
            BoxShadow(
                blurRadius: 5,
                spreadRadius: 0,
                offset: Offset(0, 4),
                color: Colors.grey[300]),]
      ),
    );
  }
}
