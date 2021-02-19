import 'package:assignment_project/screens/video_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:assignment_project/bloc/topic_bloc.dart';
import 'package:assignment_project/model/topics.dart';

class SelectTopics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShowList(),
    );
  }
}

class ShowList extends StatefulWidget {
  @override
  _ShowListState createState() => _ShowListState();
}

class _ShowListState extends State<ShowList> {

  final TopicBloc _topicBloc = TopicBloc();

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  List _items = ["Planets Of The Solar System", "Life Cycle of a Butterfly"];

  Widget slideIt(BuildContext context, int index, animation) {
    int item = _items[index];
    TextStyle textStyle = Theme
        .of(context)
        .textTheme
        .headline4;
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset(0, 0),
      ).animate(animation),
      child: SizedBox(
        height: 128.0,
        child: Card(
          color: Colors.primaries[item % Colors.primaries.length],
          child: Center(
            child: Text('Item $item', style: textStyle),
          ),
        ),
      ),
    );
  }


  @override
  void dispose() {
    _topicBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder<List<Topics>>(
          stream: _topicBloc.topicsListStream,
          builder: (BuildContext context,
              AsyncSnapshot<List<Topics>> snapshot) {
            if (snapshot.hasError) {
              return Text("Error");
            } else
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                        position: index,
                        child: SlideAnimation(
                          horizontalOffset: 10,
                          child: FadeInAnimation(
                            child: Container(
                              height: 90,margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                              child: Ink(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Color.fromRGBO(114, 9, 183,1), Color.fromRGBO(181, 23, 158,1)],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(20.0)
                                ),
                                child: ListTile(
                                  subtitle: Text("${snapshot.data[index].topicName}",
                                    style: TextStyle(fontSize: 20,letterSpacing: 1,fontWeight: FontWeight.w600,color: Colors.white),
                                  ),
                                  onTap: (){
                                    _navigateToPlayerScreen(snapshot.data[index].topicIndex,snapshot.data[index].topicName.toString());
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                    );
                  }
              );
          },
        ),
      ),
    );
  }
  void _navigateToPlayerScreen(int index, String topicName){
      Navigator.push(context, MaterialPageRoute(builder: (context) => PlayVideoScreen(topic: topicName,topicIndexNo: index,)));
  }
}
