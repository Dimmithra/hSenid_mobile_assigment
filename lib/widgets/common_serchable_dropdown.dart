import 'package:country_app/utils/color_const.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonSearchableDropdown extends StatelessWidget {
  const CommonSearchableDropdown({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.searchController,
    required this.controller,
    required this.searchMatchFn,
    required this.hint,
    this.trailingIcon,
    this.specialCharacters = true,
    this.dropdownHeight,
    this.buttonStyleDataheight,
  });

  final List<DropdownMenuItem<dynamic>>? items;
  final dynamic value;
  final void Function(dynamic)? onChanged;
  final TextEditingController? searchController;
  final TextEditingController? controller;
  final bool Function(DropdownMenuItem<dynamic>, String)? searchMatchFn;
  final String hint;
  final Widget? trailingIcon;
  final bool specialCharacters;
  final double? dropdownHeight;
  final double? buttonStyleDataheight;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: kdropdownBoaderColor),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<dynamic>(
            isDense: true,
            style: TextStyle(color: kdefTextColor, fontWeight: FontWeight.w500),
            isExpanded: true,
            hint: Text(
              hint,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: items,
            value: value,
            onChanged: onChanged,

            iconStyleData: IconStyleData(
              icon: trailingIcon ?? const Icon(Icons.arrow_drop_down),
            ),
            buttonStyleData: ButtonStyleData(
              height: buttonStyleDataheight ?? 40,
              width: 200,
            ),
            dropdownStyleData: const DropdownStyleData(maxHeight: 400),
            menuItemStyleData: MenuItemStyleData(height: dropdownHeight ?? 40),
            dropdownSearchData: DropdownSearchData(
              searchController: searchController,
              searchInnerWidgetHeight: 50,
              searchInnerWidget: Container(
                height: 50,
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 4,
                  right: 8,
                  left: 8,
                ),
                child: TextFormField(
                  expands: true,
                  maxLines: null,
                  controller: controller,
                  inputFormatters: [
                    specialCharacters
                        ? FilteringTextInputFormatter.deny(
                            RegExp(r'[!@#%^&*(),.?":{}|<>]'),
                          )
                        : FilteringTextInputFormatter.singleLineFormatter,
                  ],
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    hintText: 'Search for an item...',
                    hintStyle: const TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              searchMatchFn: searchMatchFn,
            ),
            //This to clear the search value when you close the menu
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                // searchController!.clear();
                controller!.clear();
              }
            },
          ),
        ),
      ),
    );
  }
}
