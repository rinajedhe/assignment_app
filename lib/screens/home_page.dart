import 'dart:convert';
import 'package:assignment_project/screens/result_page.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  String topicName;
  HomePage(this.topicName);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String assettoload;

  String firstJson = "assets/jsonfiles/q1.json";

  String secondJson = "assets/jsonfiles/q2.json";

  setAsset() {
    if (widget.topicName == "Planets Of The Solar System") {
      assettoload = firstJson;
    } else if (widget.topicName == "Life Cycle of a Butterfly") {
      assettoload = secondJson;
    }
  }

  @override
  Widget build(BuildContext context) {
    setAsset();
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString(assettoload,cache: false),
        builder: (context,snapshot){
            List myData = json.decode(snapshot.data.toString());
            print(myData);
            if(myData == null){
              return Scaffold(
                body: Center(child: Text("Loading.."),),
              );
            }else{
              return QuizApp(mydata: myData,assettoload: assettoload,);
            }
        });
  }
}

class QuizApp extends StatefulWidget {
  final List mydata;
  String assettoload;
  QuizApp({Key key, @required this.mydata,@required this.assettoload}) : super(key: key);
  @override
  _QuizAppState createState() => _QuizAppState(mydata);
}

class _QuizAppState extends State<QuizApp> {
  final List mydata;
  _QuizAppState(this.mydata);

  String _feedBack;
  int answeredTime;
  int marks;
  bool _isAnsWrong = false;
  bool _disableAns = false;
  int i = 1;
  CountDownController _timerController = CountDownController();

  @override
  void initState() {
  super.initState();
  }

  Map<String, Color> btncolor = {
    "0": Colors.white,
    "1": Colors.white,
    "2": Colors.white,
    "3": Colors.white,
  };

  Widget choiceButton(int options) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(height: 50,width: MediaQuery.of(context).size.width,margin: EdgeInsets.only(left: 5,right: 5),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),border: Border.all(width: 0.1),color: Colors.white),
        //padding: EdgeInsets.all(5),
        child: FlipCard(
          direction: FlipDirection.VERTICAL,
          front: Center(
            child: Text(
              mydata[0]['data']['options'][options]['label'].toString().replaceAll("<p>", "").replaceAll("</p>", '').replaceAll("&nbsp", "").replaceAll(";",""),
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Alike",
                fontSize: 18.0,
              ),textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          back: Container(decoration: BoxDecoration(
              color: mydata[0]['data']['options'][options]['isCorrect'] == 1 ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(30)
          ),
            child: mydata[0]['data']['options'][options]['isCorrect'] == 1 ? Center(child: Text("CORRECT",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)) : Center(child: Text("INCORRECT",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)) ,
          ),
          onFlip: (){
            checkAnswer(options);
            _timerController.pause();
            setState(() {
              _disableAns = true;
            });
          },
          onFlipDone: (status){
            print("onFlipDone status $status");
          },
        ),

      ),
    );
  }

  void checkAnswer(int ans)async{
    if(mydata[0]['data']['options'][ans]['isCorrect'] == 1){
      print("Answer is CORRECT");
     setState(() {
       _timerController.pause();
       btncolor[ans.toString()] = Colors.green;
       _isAnsWrong = false;
       marks = mydata[0]['data']['options'][ans]['score'];
       answeredTime =  int.parse(_timerController.getTime());
       print(answeredTime);
     });
      await Future.delayed(Duration(seconds: 2));
      Navigator.push(context, MaterialPageRoute(builder: (context) => ResultPage(marks,answeredTime)));
    }else{
      _timerController.pause();
      print("WRONG ANSWER");
      setState(() async{
        btncolor[ans.toString()] = Colors.red;
        _isAnsWrong = true;
        _feedBack = mydata[0]['data']['options'][ans]['feedback'][0]['text'].toString().
        replaceAll("<p>", "").replaceAll("</p>", '').replaceAll("&nbsp", "").replaceAll("</span>", "").
        replaceAll(";", "");
        print(_feedBack);
      });
      await Future.delayed(Duration(seconds: 3));
      btncolor[ans.toString()] = Colors.white;

    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromRGBO(114, 9, 183,1), Color.fromRGBO(181, 23, 158,1)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(0.0)
          ),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    alignment: Alignment.center,
                    child: Text(
                        mydata[0]['data']['stimulus'].toString().replaceAll("<p>", "").replaceAll("&nbsp", "").replaceAll("</p>", "").replaceAll(";", ""),
                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20,),textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(flex: 1,
                child: Container(
                  height: 10,width: double.infinity,
                  child: CircularCountDownTimer(
                    duration: 60,
                    controller: _timerController,
                    initialDuration: 0,
                    height: 10,width: 10,
                    ringColor: Colors.grey[300],
                    ringGradient: null,
                    fillColor: Colors.purpleAccent[100],
                    fillGradient: null,
                    backgroundColor: Colors.purple[500],
                    backgroundGradient: null,
                    strokeWidth: 5,
                    strokeCap: StrokeCap.round,
                    textStyle: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.bold),
                    autoStart: true,
                    isReverse: true,
                    isReverseAnimation: true,
                    textFormat: CountdownTextFormat.S,
                    isTimerTextShown: true,
                    onStart: () {
                      print('Countdown Started');
                    },
                    onComplete: () {
                      print('Countdown Ended');
                    },

                  ),
                ),),
                SizedBox(height: 10,),
                Expanded(flex: 4,
                    child: AbsorbPointer(
                      absorbing: _disableAns,
                      child: Container(margin: EdgeInsets.only(left: 5,right: 5),width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            choiceButton(0),
                            choiceButton(1),
                            choiceButton(2),
                            choiceButton(3),
                          ],
                        ),
                      ),
                    ),
                ),
                Expanded(flex: 2,
                    child: Container(margin: EdgeInsets.only(left: 10,right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _feedBack == null ? Container() : Text(_feedBack,style: TextStyle(color: Colors.white,fontSize: 14),),
                          _isAnsWrong ? FlatButton.icon(icon: Icon(Icons.replay,),color: Colors.white,
                            label: Text("Retry",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                            onPressed: (){
                            print("Retry pressed");
                              setState(() {
                                _disableAns = false;
                                _timerController.restart();
                              //reassemble();
                            });
                           // Phoenix.rebirth(context);
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.white)
                   ),) : Container(),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
    );
  }
}
