class GuessModel {
  String text;
  int distance;

  GuessModel({
    required this.text,
    required this.distance,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GuessModel &&
          runtimeType == other.runtimeType &&
          text == other.text &&
          distance == other.distance;

  @override
  int get hashCode => text.hashCode ^ distance.hashCode;
}
