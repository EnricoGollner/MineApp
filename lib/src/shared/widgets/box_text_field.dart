import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mine_app/src/core/theme/ui_helpers/ui_helpers.dart';

///Widget customizável de TextField
class BoxTextField extends StatefulWidget {
  final String? label;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixicon;
  final Function(String)? onChanged;
  final double? height;
  final TextEditingController? controller;
  final String? Function(String?)? validatorFunction;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String value)? onFieldSubmitted;
  final String? initialValue;
  final int maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final bool isPassword;
  final bool isOntapClear;
  final bool isWhite;
  final FocusNode? focusNode;
  final bool isAutoFocus;
  final Function()? onPressed;
  final VoidCallback? onEditingComplete;
  final void Function(PointerDownEvent)? onTapOutside;

  const BoxTextField({
    Key? key,
    this.label,
    required this.hintText,
    this.onFieldSubmitted,
    this.isAutoFocus = false,
    this.maxLines = 1,
    this.maxLength,
    this.prefixIcon,
    this.suffixicon,
    this.onChanged,
    this.height,
    this.controller,
    this.isPassword = false,
    this.isOntapClear = false,
    this.isWhite = false,
    this.keyboardType,
    this.validatorFunction,
    this.inputFormatters,
    this.focusNode,
    this.onPressed,
    this.initialValue,
    this.onEditingComplete,
    this.onTapOutside,
  }) : super(key: key);

  @override
  State<BoxTextField> createState() => _BoxTextFieldState();
}

class _BoxTextFieldState extends State<BoxTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: widget.label != null,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 10.0),
                child: UIText.textFieldLabelMinor(widget.label ?? ''),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
        SizedBox(
          height: widget.height,
          child: TextFormField(
            cursorColor: colorSecondary,
            style: textFieldStyle,
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
              widget.onTapOutside != null  ? widget.onTapOutside!(event) : null;

            },
            maxLength: widget.maxLength,
            onChanged: widget.onChanged,
            focusNode: widget.focusNode,
            autofocus: widget.isAutoFocus,
            onTap: widget.isOntapClear
                ? () => widget.controller!.clear()
                : () => () {},
            onFieldSubmitted: widget.onFieldSubmitted,
            initialValue: widget.initialValue,
            maxLines: widget.maxLines,
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            validator: widget.validatorFunction,
            inputFormatters: widget.inputFormatters,
            obscureText: _obscureText,
            onEditingComplete: widget.onEditingComplete,
            decoration: InputDecoration(
              counterText: "",
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: colorError, width: 2),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: colorError, width: 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: colorBorderField, width: 2),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: colorSelectedField, width: 2.5),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              prefixIcon: widget.prefixIcon != null
                  ? Icon(
                      widget.prefixIcon,
                      color: colorSecondary,
                    )
                  : null,
              prefixIconConstraints: BoxConstraints.tight(const Size(60, 25)),
              suffixIcon: widget.isPassword
                  ? GestureDetector(
                      child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        size: 24,
                        color: colorPrimary,
                      ),
                      onTap: () {
                        setState(
                          () {
                            _obscureText = !_obscureText;
                          },
                        );
                      },
                    )
                  : GestureDetector(
                      onTap: widget.onPressed,
                      child: Icon(
                        widget.suffixicon,
                        color: colorPrimary,
                      ),
                    ),
              suffixIconConstraints: BoxConstraints.tight(const Size(60, 25)),
              filled: true,
              hintStyle: hintTextStyle,
              hintText: widget.hintText,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              fillColor: widget.isWhite ? colorOnPrimary : colorTextField,
            ),
          ),
        ),
      ],
    );
  }
}
