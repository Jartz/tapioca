import "dart:typed_data";
import "dart:ui";

/// TapiocaBall is a effect to apply to the video.
abstract class TapiocaBall {
  /// Creates a object to apply color filter from [Filters].
  static TapiocaBall filter(Filters filter, double degree) {
    return _Filter(filter, degree);
  }

  /// Creates a object to apply color filter from [Color].
  static TapiocaBall filterFromColor(Color color, double degree) {
    return _Filter.color(color, degree);
  }

  /// Creates a object to overlay text.
  static TapiocaBall textOverlay(
      String text, int x, int y, int size, Color color, FontTapioca font) {
    return _TextOverlay(text, x, y, size, color, font);
  }

  /// Creates a object to overlay a image.
  static TapiocaBall imageOverlay(Uint8List bitmap, int x, int y) {
    return _ImageOverlay(bitmap, x, y);
  }

  /// Returns a [Map<String, dynamic>] representation of this object.
  Map<String, dynamic> toMap();

  /// Returns a TapiocaBall type name.
  String toTypeName();
}

/// Enum that specifies the color filter type.
enum Filters { pink, white, blue }

enum FontTapioca { Montserrat, Satisfy, Staatliches }

class _Filter extends TapiocaBall {
  String color;
  double degree;
  _Filter(Filters type, double degree) {
    switch (type) {
      case Filters.pink:
        this.color = "#ffc0cb";
        break;
      case Filters.white:
        this.color = "#ffffff";
        break;
      case Filters.blue:
        this.color = "#1f8eed";
    }
    this.degree = degree;
  }
  _Filter.color(Color colorInstance, double degree) {
    this.color = '#${colorInstance.value.toRadixString(16).substring(2)}';
    this.degree = degree;
  }

  Map<String, dynamic> toMap() {
    return {
      'type': color,
      'degree': degree,
      'toTypeName': "Filter",
    };
  }

  String toTypeName() {
    return 'Filter';
  }
}

class _TextOverlay extends TapiocaBall {
  final String text;
  final int x;
  final int y;
  final int size;
  final Color color;
  final String type = "TextOverlay";
  final FontTapioca font;
  _TextOverlay(this.text, this.x, this.y, this.size, this.color, this.font);

  Map<String, dynamic> toMap() {
    return {
      'toTypeName': type,
      'text': text,
      'x': x,
      'y': y,
      'size': size,
      'color': '#${color.value.toRadixString(16).substring(2)}',
      'font': font.toString().split('.').last
    };
  }

  String toTypeName() {
    return 'TextOverlay';
  }
}

class _ImageOverlay extends TapiocaBall {
  final Uint8List bitmap;
  final int x;
  final int y;
  _ImageOverlay(this.bitmap, this.x, this.y);

  Map<String, dynamic> toMap() {
    return {
      'bitmap': bitmap,
      'x': x,
      'y': y,
      'toTypeName': "ImageOverlay",
    };
  }

  String toTypeName() {
    return 'ImageOverlay';
  }
}
