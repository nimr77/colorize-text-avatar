import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';

class TextAvatar extends StatelessWidget {
  final Shape? shape;
  final Color? backgroundColor;
  final Color? textColor;
  final double? size;
  final String? text;
  final double? fontSize;
  final int? numberLetters;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final bool? upperCase;

  TextAvatar(
      {Key? key,
      @required this.text,
      this.textColor,
      this.backgroundColor,
      this.shape,
      this.numberLetters,
      this.size,
      this.fontWeight = FontWeight.bold,
      this.fontFamily,
      this.fontSize = 16,
      this.upperCase = false}) {
    //assert(numberLetters! > 0);
  }

  @override
  Widget build(BuildContext context) {
    final effectiveShape = (shape == null) ? Shape.Rectangle : shape;
    final effectiveSize = (size == null || size! < 32.0) ? 48.0 : size;
    final effectiveBackgroundColor =
        backgroundColor == null ? _colorBackgroundConfig() : backgroundColor;
    final effectiveTextColor = _colorTextConfig();
    return _textDisplay(effectiveShape, effectiveSize, effectiveBackgroundColor,
        effectiveTextColor);
  }

  Widget _buildText(Color? effectiveTextColor) {
    return Text(
      _textConfiguration(),
      style: TextStyle(
        color: effectiveTextColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
      ),
    );
  }

  RoundedRectangleBorder _buildTextType(
      Shape? effectiveShape, double? effectiveSize) {
    switch (effectiveShape) {
      case Shape.Rectangle:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        );
      case Shape.Circular:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(effectiveSize! / 2),
        );
      case Shape.None:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        );
      default:
        {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(effectiveSize! / 2),
          );
        }
    }
  }

  Color _colorBackgroundConfig() {
    if (RegExp(r'[A-Z]|').hasMatch(
      _textConfiguration(),
    )) {
      return colorData[_textConfiguration()[0].toLowerCase().toString()]!;
    }
    return Colors.transparent; // Default color if no match
  }

  Color _colorTextConfig() {
    return textColor ?? Colors.white;
  }

  String _textConfiguration() {
    var newText = text == null ? '?' : _toString(value: text);
    newText = upperCase! ? newText.toUpperCase() : newText;
    var arrayLeeters = newText.trim().split(' ');

    if (arrayLeeters.length > 1 && arrayLeeters.length == numberLetters) {
      return '${arrayLeeters[0][0].trim()}${arrayLeeters[1][0].trim()}';
    }

    return '${newText[0]}';
  }

  Widget _textDisplay(Shape? effectiveShape, double? effectiveSize,
      Color? effectiveBackgroundColor, Color? effectiveTextColor) {
    return Container(
      child: Material(
        shape: _buildTextType(effectiveShape, effectiveSize),
        color: effectiveBackgroundColor,
        child: Container(
          height: effectiveSize,
          width: effectiveSize,
          child: Center(
            child: _buildText(effectiveTextColor),
          ),
        ),
      ),
    );
  }

  String _toString({String? value}) {
    return String.fromCharCodes(
      value!.runes.toList(),
    );
  }
}
