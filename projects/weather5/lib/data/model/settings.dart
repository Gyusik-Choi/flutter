class Settings {
  final String background;

  Settings({ required this.background });

  Map<String, dynamic> toMap() {
    return {
      'background': background,
    };
  }

  @override
  String toString() {
    return 'Dog{ background: $background }';
  }
}
