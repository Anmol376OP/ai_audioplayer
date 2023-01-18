import 'dart:convert';

import 'package:ai_audioplayer/utils/ai_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List Items = [];
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/radio.json');
    final data = await json.decode(response);
    setState(() {
      Items = data["radios"];
    });
    print(Items);
  }
  @override
  void initState(){
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: Stack(
        children: [
          VxAnimatedBox()
              .size(context.screenWidth, context.screenHeight)
              .withGradient(LinearGradient(
                  colors: [AIUtil.primaryColor1, AIUtil.primaryColor2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight))
              .make(),
          AppBar(
            title: "AI Radio".text.xl4.bold.white.make().shimmer(
                primaryColor: Vx.purple300, secondaryColor: Colors.white),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ).h(context.screenHeight * 14.5).p(16),
          //
          Items.isNotEmpty?ListView.builder(
            itemCount: Items.length,
            itemBuilder: (context,index){
              return Card(
                key: ValueKey(Items[index]["id"]),
                margin: const EdgeInsets.all(10),
                color: Colors.amber.shade100,
                child: SingleChildScrollView(
                  child: Image.network(Items[index]["image"]),
                ),
              );
            },
            ):Container()
        ],
      ),
    );
  }
}
