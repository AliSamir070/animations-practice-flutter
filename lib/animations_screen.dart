import 'package:flutter/material.dart';

class AnimationsScreen extends StatefulWidget {
  const AnimationsScreen({super.key});

  @override
  State<AnimationsScreen> createState() => _AnimationsScreenState();
}

class _AnimationsScreenState extends State<AnimationsScreen> with TickerProviderStateMixin {
  bool isAligned = false;
  bool isAligned2 = false;
  late AnimationController controller;
  double animatedContainerHeight = 100;
  double animatedContainerWidth = 100;
  double animatedContainerRadius = 20;
  var animatedContainerColor = Colors.purple;
  CrossFadeState crossFadeState = CrossFadeState.showFirst;
  double fontSize = 18;
  FontWeight weight = FontWeight.w400;
  Color fontColor = Colors.deepOrangeAccent;
  String text = "Animate Me";
  List<String> courses = [
    "Flutter",
    "Android",
    "Ios",
    "React Native",
  ];
  var animatedListKey = GlobalKey<AnimatedListState>();
  @override
  void initState() {
    super.initState();
    controller = AnimationController(lowerBound:-300,upperBound: 0,vsync: this,duration: Duration(milliseconds: 2000))
    ..forward();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AnimatedAlign(
                      curve: Curves.easeInQuad,
                      alignment: isAligned?Alignment.bottomRight:Alignment.topLeft,
                      duration: Duration(milliseconds: 2000),
                      child: InkWell(
                          onTap: (){
                            setState(() {
                              isAligned = !isAligned;
                              isAligned2 = !isAligned2;
                            });
                          },
                          child: Image.asset("assets/images/Untitled4.png",height: 100,width: 100,))),
                  AnimatedAlign(
                      curve: Curves.easeInQuad,
                      alignment: !isAligned2?Alignment.bottomRight:Alignment.topLeft,
                      duration: Duration(milliseconds: 2000),
                      child: InkWell(
                          onTap: (){
                            setState(() {
                              isAligned2 = !isAligned2;
                              isAligned = !isAligned;
                            });
                          },
                          child: Image.asset("assets/images/Untitled4.png",height: 100,width: 100,))),
                  AnimatedBuilder(
                      animation: controller,
                      child: InkWell(
                          onTap: (){
                          },
                          child: Image.asset("assets/images/Untitled7.png",height: 100,width: 100,)),
                      builder: (context,child)=>Transform.translate(
                        offset: Offset(controller.value, 0),
                        child: child,
                      )
                  ),
                  InkWell(
                    onTap: (){
                      changeAnimatedContainerValues();
                    },
                    child: AnimatedContainer(
                        duration: Duration(milliseconds: 3000),
                        height: animatedContainerHeight,
                        width: animatedContainerWidth,
                        decoration: BoxDecoration(
                          color: animatedContainerColor,
                          borderRadius: BorderRadius.circular(animatedContainerRadius)
                        ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 100,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                  SizedBox(height: 10,),
                  AnimatedCrossFade(
                      firstChild: Image.asset("assets/images/Untitled7.png",height: 100,width: 100,),
                      secondChild: Image.asset("assets/images/Untitled4.png",height: 50,width: 50,),
                      crossFadeState: crossFadeState,
                      firstCurve: Curves.easeInOut,
                      secondCurve: Curves.easeInOut,
                      sizeCurve: Curves.easeInCirc,
                      duration: Duration(milliseconds: 800)),
                  SizedBox(height: 10,),
                  Container(
                    height: 100,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                  SizedBox(height: 30,),
                  AnimatedDefaultTextStyle(

                    style: TextStyle(
                        fontSize: fontSize,
                        color: fontColor,
                        fontWeight: weight
                    ),
                    duration: Duration(milliseconds: 800),
                    child: Text(
                      text,

                    ),
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
                      onPressed: (){
                        setState(() {
                          if(crossFadeState == CrossFadeState.showFirst){
                            crossFadeState = CrossFadeState.showSecond;
                          }else{
                            crossFadeState = CrossFadeState.showFirst;
                          }
                          if(text == "Animate Me"){
                            text = "Thank you";
                            fontSize = 24;
                            weight = FontWeight.bold;
                            fontColor = Colors.indigo;
                          }else{
                            fontSize = 18;
                            weight = FontWeight.w400;
                            fontColor = Colors.deepOrangeAccent;
                            text = "Animate Me";
                          }
                        });
                      },
                      child: Text("Animate"))
                ],
              ),
            ),
          ),
          Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: AnimatedList(
                        key: animatedListKey,
                        padding: EdgeInsets.all(20),
                        initialItemCount: courses.length,
                        itemBuilder: (context , index,animation){
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(-1, 0),
                              end: const Offset(0, 0),
                            ).animate(animation),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 100,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                color: Colors.tealAccent,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                courses[index],
                                style: TextStyle(
                                  color: Colors.deepOrangeAccent,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          );
                        }
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: (){
                            courses.insert(0,"HarmonyOs");
                            animatedListKey.currentState?.insertItem(0);
                          },
                          child: Text("Add")),
                      ElevatedButton(
                          onPressed: (){
                            courses.removeAt(0);
                            animatedListKey.currentState?.removeItem(
                                0,
                                    (context, animation) => SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(-1, 0),
                                        end: const Offset(0, 0),
                                      ).animate(animation),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 100,
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(bottom: 20),
                                        decoration: BoxDecoration(
                                          color: Colors.tealAccent,
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: Text(
                                          courses[0],
                                          style: TextStyle(
                                              color: Colors.deepOrangeAccent,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ));
                          },
                          child: Text("Remove")),
                    ],
                  )
                ],
              )
          )
        ],
      ),
    );
  }
  void changeAnimatedContainerValues(){
    setState(() {
      animatedContainerRadius = 40;
      animatedContainerColor = Colors.blueGrey;
      animatedContainerHeight = 200;
      animatedContainerWidth = 200;
    });
  }
}

