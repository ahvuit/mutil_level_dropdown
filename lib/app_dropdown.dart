import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

typedef OnDropDownItemChanged<T> = Function(T);
typedef MapDropDownText<T> = Widget Function(T);

class GenericDropDown<T> extends StatelessWidget {
  final OnDropDownItemChanged<T?> onDropDownItemChanged;
  final MapDropDownText<T> mapDropDownText;
  final List<T> items;
  final T? value;
  final Widget? icon;
  final Color? iconColor;
  final Color? dropDownColor;
  final String? hintText;
  final String? dropdownLabel;
  final Color? dropdownLabelColor;
  final TextStyle? hintTextStyle;
  final TextStyle? dropdownLabelStyle;
  final TextStyle? textStyle;
  final Color? textColor;
  final Color? hintColor;
  final bool isRequired;
  final bool useTransparentBorder;
  final bool useBottomPadding;
  final InputDecoration? decoration;
  final EdgeInsets? contentPadding;
  final bool filled;
  final Color? fillColor;
  final Widget? leading;
  final Color? dropdownPopupBgColor;
  final double? paddingBetweenLabelAndDropdown;
  final double? widthButtonStyleData;
  final Color? borderColor;
  final Color? hoverColor;
  final Widget? hint;

  const GenericDropDown({
    Key? key,
    required this.items,
    required this.mapDropDownText,
    required this.onDropDownItemChanged,
    this.contentPadding,
    this.value,
    this.dropDownColor,
    this.dropdownLabel,
    this.dropdownLabelStyle,
    this.dropdownLabelColor,
    this.hint,
    this.hintText,
    this.hintTextStyle,
    this.textStyle,
    this.textColor,
    this.leading,
    this.hintColor,
    this.dropdownPopupBgColor,
    this.paddingBetweenLabelAndDropdown,
    this.fillColor,
    this.filled = true,
    this.useBottomPadding = true,
    this.useTransparentBorder = false,
    this.isRequired = false,
    this.icon,
    this.iconColor,
    this.decoration,
    this.widthButtonStyleData,
    this.borderColor,
    this.hoverColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Container(
        decoration: BoxDecoration(
          color: borderColor ?? Colors.white,
          borderRadius: BorderRadius.circular(
            10,
          ),
          border: Border.all(color: borderColor ?? Colors.white),
        ),
        child: DropdownButton2<T>(
          isDense: true,
          isExpanded: true,
          hint: hint ??
              Text(
                hintText ?? '',
                style: hintTextStyle ??
                    const TextStyle(
                      fontSize: 5,
                      color: Colors.black45,
                      fontWeight: FontWeight.w400,
                    ),
              ),
          style: textStyle ??
              const TextStyle(
                color: Colors.blueGrey,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
          menuItemStyleData: MenuItemStyleData(
            overlayColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.hovered)) {
                  return hoverColor ?? Colors.greenAccent;
                }
                if (states.contains(WidgetState.focused) ||
                    states.contains(WidgetState.pressed)) {
                  return hoverColor ?? Colors.greenAccent;
                }
                return null;
              },
            ),
          ),
          buttonStyleData: ButtonStyleData(
            height: 50,
            padding: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10,
              ),
              color: fillColor ?? Colors.blueGrey,
            ),
            elevation: 0,
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            //elevation: 0,
          ),
          alignment: AlignmentDirectional.centerStart,
          value: (value != null)
              ? value
              : (hintText == null)
                  ? items.first
                  : null,
          items: items
              .map((e) => DropdownMenuItem<T>(
                    value: e,
                    child: mapDropDownText(e),
                  ))
              .toList(),
          onChanged: (value) {
            onDropDownItemChanged(value);
          },
          iconStyleData: IconStyleData(
            icon: icon ??
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: iconColor ?? Colors.grey,
                ),
          ),
        ),
      ),
    );
  }
}
