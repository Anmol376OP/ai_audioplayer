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
    // print(Items);
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      body: Stack(
        fit: StackFit.expand,
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
          // const SizedBox(height: 100,),
          VxSwiper.builder(
              itemCount: Items.length,
              aspectRatio: 1.0,
              itemBuilder: (context, index) {
                final rad = Items[index];
                return VxBox(
                        child: ZStack([
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: VStack(
                      [
                        Text(Items[index]["name"]).text.white.bold.xl3.make(),
                        Text(Items[index]["tagline"])
                            .text
                            .white
                            .semiBold
                            .make(),
                      ],
                      crossAlignment: CrossAxisAlignment.center,
                    ),
                  )
                ]))
                    .bgImage(DecorationImage(
                        image: NetworkImage(Items[index]["image"]),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.3), BlendMode.darken)))
                    .border(color: Colors.black, width: 5.0)
                    .withRounded(value: 60.0)
                    .make()
                    .p12()
                    .centered();
              })
        ],
      ),
    );
  }
}
