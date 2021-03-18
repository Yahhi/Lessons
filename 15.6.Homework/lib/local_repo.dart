class LocalRepo {
  final List<String> _data = List<String>();

  void addString(String text) {
    _data.add(text);
  }

  String getAnyString() {
    if (_data.length < 1) return null;
    _data.shuffle();
    return _data.first;
  }
}
