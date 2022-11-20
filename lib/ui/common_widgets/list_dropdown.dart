import 'package:flutter/material.dart';

class ListDropdown<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>>? items;
  final void Function(dynamic)? onChanged;
  final T? value;
  final bool isLoading;
  final String title;
  final Widget? hint;

  const ListDropdown(
      {Key? key,
      required this.items,
      required this.onChanged,
      this.value,
      this.isLoading = false,
      this.title = "",
      this.hint})
      : super(key: key);

  @override
  State<ListDropdown> createState() => _ListDropdownState();
}

class _ListDropdownState extends State<ListDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: ListTile(
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.caption,
        ),
        subtitle: DropdownButton(
          key: UniqueKey(),
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
          hint: widget.hint,
          value: widget.value,
          items: widget.items,
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
