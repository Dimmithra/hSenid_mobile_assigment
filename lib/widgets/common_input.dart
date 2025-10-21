import 'package:country_app/utils/color_const.dart';
import 'package:flutter/material.dart';

class CommonInputFeild extends StatefulWidget {
  const CommonInputFeild({
    super.key,
    required this.controller,
    this.maxLines = 1,
    this.maxLength,
    this.passwordText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.boaderEnable = true,
    this.hintText,
    this.isValidate = false,
    this.valdationMessage,
    this.readOnly = false,
    this.fill = true,
    this.fillColor,
    this.keyboardType,
    this.expands = false,
    this.label,
    this.onTap,
    this.onChanged,
  });

  final TextEditingController? controller;
  final int? maxLines;
  final int? maxLength;
  final bool passwordText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool boaderEnable;
  final String? hintText;
  final bool isValidate;
  final String? valdationMessage;
  final bool readOnly;
  final bool fill;
  final Color? fillColor;
  final TextInputType? keyboardType;
  final bool expands;
  final Widget? label;
  final Function(String)? onChanged;
  final Function()? onTap;
  @override
  State<CommonInputFeild> createState() => _CommonInputFeildState();
}

class _CommonInputFeildState extends State<CommonInputFeild> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextFormField(
            expands: widget.expands,
            onTap: widget.onTap,
            onChanged: widget.onChanged,
            readOnly: widget.readOnly,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            maxLength: widget.maxLength,
            maxLines: !widget.passwordText ? widget.maxLines : 1,
            obscureText: widget.passwordText,
            validator: (text) {
              if (widget.isValidate) {
                if (text == null || text.isEmpty) {
                  return '${widget.valdationMessage ?? widget.hintText} is Required';
                }
                return null;
              }
              return null;
            },
            decoration: InputDecoration(
              label: widget.label,
              labelStyle: TextStyle(
                color: kdefTextColor,
                fontWeight: FontWeight.w700,
              ),
              hintText: widget.hintText,
              filled: widget.fill,
              fillColor: widget.fillColor ?? Colors.white,
              hintStyle: TextStyle(
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: kHintlableColor,
              ),
              // TextStyle(
              //   color: const Color.fromARGB(255, 121, 121, 121),
              //   fontWeight: FontWeight.w700,
              // ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 14,
              ),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: DefaultSelectionStyle.defaultColor,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ), // flat style
              focusedBorder: widget.fill
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ktextfeildBoaderColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    )
                  : UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
              enabledBorder: widget.fill
                  ? OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    )
                  : UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
