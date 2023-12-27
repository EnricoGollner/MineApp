import 'package:flutter/material.dart';
import 'package:mine_app/src/core/theme/ui_helpers/ui_helpers.dart';

///cria um dropDown customizado
class BoxDropdownVertical extends StatelessWidget {
  final Function(dynamic)? onChanged;
  final IconData? prefixIconData;
  final dynamic initialValue;
  final List<DropdownMenuItem<Object>> items;
  final String label;
  final String? disabledHintText;
  final String? hintText;
  final FocusNode? focusNode;
  final bool enabled;
  final VoidCallback? onTap;
  final bool isWhite;

  const BoxDropdownVertical({
    Key? key,
    this.prefixIconData,
    required this.onChanged,
    required this.initialValue,
    required this.items,
    required this.label,
    this.disabledHintText,
    this.hintText,
    this.focusNode,
    this.enabled = true,
    this.onTap,
    required this.isWhite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: UIText.dropdownLabel(label),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<dynamic>(
            disabledHint: disabledHintText != null ? UIText.dropdownHintRunning(disabledHintText!) : null,
            focusNode: focusNode,
            hint: hintText != null ? UIText.dropdownLabel(hintText!) : null,
            onTap: null,
            isExpanded: true,
            style: dropdownTextStyle,
            dropdownColor: colorSecondary,
            decoration: InputDecoration(
              prefixIconConstraints: BoxConstraints.tight(const Size(60, 25)),
              prefixIcon: prefixIconData != null
                  ? Icon(
                      prefixIconData,
                      color: colorSecondary,
                    )
                  : null,
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: colorError, width: 2),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: colorError, width: 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: colorOnPrimary, width: 2),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: colorError, width: 2),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: colorSelectedField, width: 2.5),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              filled: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              fillColor: isWhite ? colorOnPrimary : Colors.transparent,
            ),
            onChanged: enabled ? onChanged : null,
            value: enabled ? initialValue : null,
            items: items,
          ),
        ],
      ),
    );
  }
}
