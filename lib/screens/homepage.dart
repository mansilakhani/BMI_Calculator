import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../color.dart';
import '../string.dart';
import '../text_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int ageValue = 30;
  int weightValue = 45;
  var value = 180.0;

  TextEditingController weigthController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  double heightFinal = 0;
  double bmiTotal = 0;
  String health = "NORMAL WEIGHT";

  late AnimationController animationController;
  late Animation<Offset> femaleanimation;
  late Animation<Offset> maleanimation;
  late Animation<Offset> heightanimation;
  late Animation<Offset> weightanimation;
  late Animation<Offset> ageanimation;
  late Animation<Offset> calcanimation;

  @override
  void initState() {
    weigthController.text = weightValue.toString();
    ageController.text = ageValue.toString();
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    heightanimation = Tween<Offset>(
      begin: Offset(0, -1),
      end: Offset.zero,
    ).animate(animationController);

    femaleanimation = Tween<Offset>(
      begin: Offset(-1, -1),
      end: Offset.zero,
    ).animate(animationController);

    maleanimation = Tween<Offset>(
      begin: const Offset(1, -1),
      end: Offset.zero,
    ).animate(animationController);

    weightanimation = Tween<Offset>(
      begin: const Offset(-1, 1),
      end: Offset.zero,
    ).animate(animationController);

    ageanimation = Tween<Offset>(
      begin: const Offset(1, 1),
      end: Offset.zero,
    ).animate(animationController);

    calcanimation = Tween<Offset>(
      begin: Offset(0, -1),
      end: Offset.zero,
    ).animate(animationController);

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: bmiCalcBG,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Center(
                      child: Text(
                    bmiCalculator,
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  )),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Expanded(
                          child: SlideTransition(
                            position: femaleanimation,
                            child: InkWell(
                              onTap: () {
                                colorPink1 = Colors.white;
                                colorPink2 = colorPink;
                                setState(() {});
                              },
                              child: Container(
                                height: 200,
                                decoration: containDeco,
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.female,
                                      size: 150,
                                      color: colorPink1,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      female,
                                      style: TextStyle(
                                          fontSize: 20, color: colorWhite),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Expanded(
                          child: SlideTransition(
                            position: maleanimation,
                            child: InkWell(
                              onTap: () {
                                colorPink2 = Colors.white;
                                colorPink1 = colorPink;
                                setState(() {});
                              },
                              child: Container(
                                height: 200,
                                decoration: containDeco,
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.male,
                                      size: 150,
                                      color: colorPink2,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      male,
                                      style: TextStyle(
                                          fontSize: 20, color: colorWhite),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SlideTransition(
                    position: heightanimation,
                    child: Container(
                      height: 180,
                      width: 350,
                      padding: const EdgeInsets.all(10),
                      decoration: containDeco,
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            height,
                            style: const TextStyle(color: Color(0xFF626473)),
                          ),
                          Hero(
                            tag: 'height',
                            child: Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: value.toInt().toString(),
                                  style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.w400,
                                      color: colorWhite)),
                              const TextSpan(
                                  text: " cm",
                                  style: TextStyle(
                                      color: Color(0xFF626473),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15)),
                            ])),
                          ),
                          Container(
                            width: 400,
                            child: SliderTheme(
                              data: SliderThemeData(
                                  thumbColor: colorSliderThumb,
                                  trackHeight: 0.2,
                                  activeTrackColor: colorSliderActive,
                                  inactiveTrackColor: colorSliderInactive),
                              child: Slider(
                                  // inactiveColor: colorSliderInactive,
                                  // activeColor: colorSliderActive,
                                  value: value,
                                  min: 1.0,
                                  max: 400.0,
                                  onChanged: (data) {
                                    value = data;
                                    // print(value);
                                    setState(() {});
                                  }),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  ///last row
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Expanded(
                          child: SlideTransition(
                            position: weightanimation,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              height: 200,
                              decoration: containDeco,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    weight,
                                    style: TextStyle(
                                        fontSize: 15, color: colorWhite),
                                  ),
                                  Container(
                                    height: 80,
                                    child: TextField(
                                      onSubmitted: (data) {
                                        weightValue = int.parse(data);
                                      },
                                      controller: weigthController,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: colorWhite,
                                        fontSize: 50,
                                      ),
                                      cursorColor: bmiCalcBG,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(3)
                                      ],
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      FloatingActionButton(
                                        onPressed: () {
                                          setState(() {
                                            weightValue++;
                                            weigthController.text =
                                                weightValue.toString();
                                          });
                                        },
                                        child: const Icon(Icons.add),
                                        backgroundColor:
                                            const Color(0xFF4C4F5E),
                                        mini: true,
                                      ),
                                      FloatingActionButton(
                                        onPressed: () {
                                          setState(() {
                                            weightValue--;
                                            weigthController.text =
                                                weightValue.toString();
                                          });
                                        },
                                        child: const Icon(CupertinoIcons.minus),
                                        backgroundColor:
                                            const Color(0xFF4C4F5E),
                                        mini: true,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Expanded(
                          child: SlideTransition(
                            position: ageanimation,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              height: 200,
                              decoration: containDeco,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    age,
                                    style: TextStyle(
                                        fontSize: 15, color: colorWhite),
                                  ),
                                  Container(
                                    height: 80,
                                    child: TextField(
                                      onSubmitted: (data) {
                                        ageValue = int.parse(data);
                                      },
                                      controller: ageController,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: colorWhite,
                                        fontSize: 50,
                                      ),
                                      cursorColor: bmiCalcBG,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(3),
                                      ],
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      FloatingActionButton(
                                        onPressed: () {
                                          setState(() {
                                            ageValue++;
                                            ageController.text =
                                                ageValue.toString();
                                          });
                                        },
                                        child: const Icon(Icons.add),
                                        backgroundColor:
                                            const Color(0xFF4C4F5E),
                                        mini: true,
                                      ),
                                      FloatingActionButton(
                                        onPressed: () {
                                          setState(() {
                                            ageValue--;
                                            ageController.text =
                                                ageValue.toString();
                                          });
                                        },
                                        child: const Icon(CupertinoIcons.minus),
                                        backgroundColor:
                                            const Color(0xFF4C4F5E),
                                        mini: true,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  InkWell(
                    onTap: () {
                      heightFinal = (value / 100) * (value / 100);
                      bmiTotal = weightValue / heightFinal;
                      if (bmiTotal < 18.5) {
                        health = "UNDERWEIGHT";
                      } else if (bmiTotal >= 18.5 && bmiTotal < 25) {
                        health = "NORMAL WEIGHT";
                      } else if (bmiTotal >= 25 && bmiTotal < 30) {
                        health = "OVERWEIGHT";
                      } else {
                        health = "OBESE";
                      }

                      _modalBottomSheetMenu();
                    },
                    child: SlideTransition(
                      position: calcanimation,
                      child: Container(
                        width: 350,
                        height: 50,
                        decoration: BoxDecoration(
                            color: const Color(0xFFEB1555),
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                            child: Text(
                          calculate,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 20),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (builder) {
          return Container(
            height: 350.0,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: Padding(
              padding: const EdgeInsets.all(35),
              child: Container(
                  decoration: BoxDecoration(
                    color: bmiCalcBG,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Your BMI is: ",
                        style: TextStyle(color: colorWhite, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: 250,
                        height: 60,
                        decoration: BoxDecoration(
                            color: const Color(0xFF1D1E33),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Hero(
                            tag: 'bmiTotal',
                            child: Text(
                              bmiTotal.toDouble().toStringAsFixed(2).toString(),
                              style: TextStyle(
                                  color: colorSliderThumb,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        health,
                        style: TextStyle(
                            color: colorWhite,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            shadows: [
                              Shadow(
                                  color: colorSliderThumb,
                                  blurRadius: 15.0,
                                  offset: const Offset(1, 1))
                            ]),
                      ),
                    ],
                  )),
            ),
          );
        });
  }
}
