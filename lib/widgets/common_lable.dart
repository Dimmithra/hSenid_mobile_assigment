import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CommonLable extends StatefulWidget {
  const CommonLable({
    super.key,
    this.fontSize,
    required this.labelName,
    this.color,
    this.enableNotoSerif = false,
    this.fontWeight,
    this.textAlign,
    this.fontStyle,
    this.decorationThickness,
    this.decoration,
    this.decorationStyle,
    this.decorationColor,
  });

  final dynamic labelName;
  final double? fontSize;
  final Color? color;
  final bool enableNotoSerif;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;
  final double? decorationThickness;
  final TextDecoration? decoration;
  final TextDecorationStyle? decorationStyle;
  final Color? decorationColor;
  @override
  State<CommonLable> createState() => _CommonLableState();
}

class _CommonLableState extends State<CommonLable> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.labelName,
      textAlign: widget.textAlign,
      style: widget.enableNotoSerif == true
          ? GoogleFonts.notoSerif(
              fontSize: widget.fontSize,
              fontWeight: widget.fontWeight,
              fontStyle: widget.fontStyle,
              decoration: widget.decoration,
              decorationStyle: widget.decorationStyle,
              decorationThickness: widget.decorationThickness,
              color: widget.color,
            )
          : GoogleFonts.lato(
              fontSize: widget.fontSize,
              fontStyle: widget.fontStyle,
              fontWeight: widget.fontWeight,
              decoration: widget.decoration,
              decorationStyle: widget.decorationStyle,
              decorationThickness: widget.decorationThickness,
              decorationColor: widget.decorationColor,
              color: widget.color,
            ),
    );
  }
}
