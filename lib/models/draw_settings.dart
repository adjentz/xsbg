class DrawSettings {
  final String name;
  final String description;
  final int colorHex;
  final int strokeWidth;
  final bool gridSnap;
  final bool temporary;

  DrawSettings(
      {this.name,
      this.colorHex = 0xFFF,
      this.strokeWidth = 3,
      this.gridSnap = true,
      this.temporary = false,
      this.description});

  static List<DrawSettings> _presets = [
    DrawSettings(
      name: 'Wall',
      description: 'Thick brown grid-snapped lines',
      colorHex: 0xff964B00,
      gridSnap: true,
      strokeWidth: 12,
    ),
    DrawSettings(
      name: 'Window',
      description: 'Thin blue grid-snapped lines',
      colorHex: 0xff0000ff,
      gridSnap: true,
      strokeWidth: 4,
    ),
    DrawSettings(
        name: 'Scribble',
        description: 'Free-style red line',
        colorHex: 0xffFF0000,
        gridSnap: false,
        strokeWidth: 6),
    DrawSettings(
        name: 'Quick Scribble',
        description: 'Fading free-style red line',
        colorHex: 0xffFF0000,
        gridSnap: false,
        temporary: true,
        strokeWidth: 6),
  ];
  static Iterable<DrawSettings> get presets => _presets;
}
