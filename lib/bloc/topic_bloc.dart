import 'dart:async';
import 'package:assignment_project/model/topics.dart';

class TopicBloc{
  List<Topics> _topicsList = [
    Topics(1, "Planets Of The Solar System"),
    Topics(2, "Life Cycle of a Butterfly"),
  ];

  final _topicsListStreamController = StreamController<List<Topics>>();

  // getters
  Stream<List<Topics>> get topicsListStream => _topicsListStreamController.stream;

  StreamSink<List<Topics>> get topicsListSink => _topicsListStreamController.sink;

  TopicBloc(){
    _topicsListStreamController.add(_topicsList);
  }

  void dispose(){
    _topicsListStreamController.close();
  }
}