import 'package:assignment_project/screens/home_page.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class CountDownPage extends StatelessWidget {
  String topicName;
  CountDownPage(this.topicName);
  String assettoload;
  CountDownController _timerController = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromRGBO(114, 9, 183,1), Color.fromRGBO(181, 23, 158,1)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            //borderRadius: BorderRadius.circular(20.0)
        ),
          child: Column(
            children: [
              SizedBox(height: 50,),
              Container(height: 100,
                  child: Text("Get Ready!",style: TextStyle(color: Colors.white,fontSize: 34,fontWeight: FontWeight.bold),)),
              SizedBox(height: 50,),
              Container(
                height: 100,width: double.infinity,
                child: CircularCountDownTimer(
                  duration: 5,
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(topicName)));
                  },

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
