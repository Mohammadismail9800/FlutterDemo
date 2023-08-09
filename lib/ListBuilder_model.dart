import 'package:flutter/material.dart';

class ListBuilder extends StatefulWidget {
  const ListBuilder({
    Key? key,
    required this.selectedList,
    required this.isSelectionMode,
    required this.onSelectionChange,
  }) : super(key: key);

  final bool isSelectionMode;
  final List<bool> selectedList;
  final Function(bool)? onSelectionChange;

  @override
  State<ListBuilder> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  void _toggle(int index) {
    if (widget.isSelectionMode) {
      setState(() {
        widget.selectedList[index] = !widget.selectedList[index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.selectedList.length,
        itemBuilder: (_, int index) {
          return ListTile(
            onTap: () => _toggle(index),
            onLongPress: () {
              if (!widget.isSelectionMode) {
                setState(() {
                  widget.selectedList[index] = true;
                });
                widget.onSelectionChange!(true);
              }
            },
            leading: const Icon(Icons.add),
            title: Text('item $index'),
            trailing: widget.isSelectionMode
                ? Checkbox(
                    value: widget.selectedList[index],
                    onChanged: (bool? x) => _toggle(index),
                  )
                : const SizedBox.shrink(),
          );
        });
  }
}
