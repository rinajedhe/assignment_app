class Topics{
  int _topicIndex;
  String _topicName;

  Topics(this._topicIndex, this._topicName);

  String get topicName => _topicName;

  set topicName(String value) {
    _topicName = value;
  }

  int get topicIndex => _topicIndex;

  set topicIndex(int value) {
    _topicIndex = value;
  }
}