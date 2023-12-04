import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_box/core/domain/bloc/theme/theme.bloc.dart';

class Select extends StatelessWidget {
  final List<String> values;
  final String currentValue;
  final String title;
  final BuildContext parentContext;
  final void Function(String? value) onSelect;

  const Select({
    required this.values,
    required this.currentValue,
    required this.title,
    required this.onSelect,
    required this.parentContext,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: parentContext.read<ThemeBloc>().state.theme.background,
      body: Center(
        child: DropdownButton(
          value: currentValue,
          icon: const Icon(Icons.keyboard_arrow_down),
          isExpanded: true,
          items: values.map((String dropDownValue) {
            return DropdownMenuItem(
              value: dropDownValue,
              child: Text(
                dropDownValue,
              ),
            );
          }).toList(),
          hint: Text(title,
              style: TextStyle(
                color: parentContext.read<ThemeBloc>().state.theme.text,
              )),
          onChanged: onSelect,
        ),
      ),
    );
  }
}
