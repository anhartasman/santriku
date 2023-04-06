import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ReusableFormField {
  static Widget dropdown<T>(
    BuildContext context, {
    required String name,
    Function(T?)? onChanged,
    required String Function(T) itemText,
    List<T> items = const [],
    String? hintText,
  }) {
    return FormBuilderDropdown<T>(
      name: name,
      decoration: InputDecoration(
        fillColor: Colors.white,
        hintText: hintText,
        border: const UnderlineInputBorder(),
      ),
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      style: TextStyle(color: Colors.grey[700], fontSize: 16),
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<T>>((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              itemText(value),
            ),
          ),
        );
      }).toList(),
      validator: FormBuilderValidators.compose(
        [
          // FormBuilderValidators.required(context),
        ],
      ),
    );
  }
}
