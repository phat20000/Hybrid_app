import 'package:flutter/material.dart';

class AddressSelectedOutline<T> extends StatelessWidget {
  final FormFieldValidator<String?> onValidator;
  final ValueChanged<T?> onChangedValue;
  final T selectedValue;
  final DropdownButtonBuilder? selectedItemBuilder;
  final List<DropdownMenuItem<T>>? items;

  const AddressSelectedOutline({
    Key? key,
    required this.onChangedValue,
    required this.selectedValue,
    required this.onValidator,
    this.selectedItemBuilder,
    this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: onValidator,
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
            labelStyle: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
            errorStyle: const TextStyle(
              color: Colors.redAccent,
              fontSize: 16.0,
            ),
            hintText: 'Please select city',
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          isEmpty: selectedValue.toString().isEmpty,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              style: const TextStyle(color: Colors.black),
              iconEnabledColor: Colors.white,
              value: selectedValue,
              isDense: true,
              onChanged: onChangedValue,
              selectedItemBuilder: selectedItemBuilder,
              items: items,
            ),
          ),
        );
      },
    );
  }
}
