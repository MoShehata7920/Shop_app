// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class BoardingModel {
  // i stopped here today and i will create this class later to add content to
  // every screen of the boarding screen
}

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) => buildBoardingItem(),
                itemCount: 3,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  'Indicator',
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Expanded(
            child: Image(
              image: AssetImage('assets/images/onboard_1.png'),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            'Screen  Title',
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Screen  Body',
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
        ],
      );
}
