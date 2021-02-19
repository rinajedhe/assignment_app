import 'package:assignment_project/screens/select_topics.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
   int marks;
   int timeTaken;
   ResultPage(this.marks, this.timeTaken);
  @override
  _ResultPageState createState() => _ResultPageState(marks,timeTaken);
}

class _ResultPageState extends State<ResultPage> {
  int marks;
  int timeTaken;
  _ResultPageState(this.marks, this.timeTaken);

  @override
  void initState() {
    checkMarks(marks);
    super.initState();
    print("Inside Result page\n Marks $marks \n TimeTaken $timeTaken");
  }
  String result;
  void checkMarks(int marks){
  if(marks <2)
  {
    result = 'You Can do better !';
  }else if(marks >=2){
    result = 'Excellent !';
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(width: double.infinity,
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
                SizedBox(height: 50,),
                //Text(result),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: result == null ? Text("") : Text(result,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 36),),
                ),
                //Text(timeTaken.toString()),
                SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: marks == null ? Text("") : Text("You Scored $marks",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 36),),
                ),
                SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:timeTaken == null ? Text("") :  Text("In $timeTaken Second",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 36),),
                ),
                SizedBox(height: 5,),
                Image.asset('assets/images/trophy.png',height: 250,width: 180,),
                FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red,width: 1)
                    ),
                    onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SelectTopics()));
                }, child: Text("Start Again",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),)),
                SizedBox(height: 10,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
