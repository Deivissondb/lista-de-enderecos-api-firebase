import 'package:flutter/material.dart';

class ButtomWidget extends StatefulWidget {
  final String name;

  final void Function() onClicked;

  const ButtomWidget({
    Key? key,
    required this.name,
    required this.onClicked,
  }) : super(key: key);

  @override
  State<ButtomWidget> createState() => _ButtomWidgetState();
}

class _ButtomWidgetState extends State<ButtomWidget> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClicked,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            widget.name,
            style: const TextStyle(color: Colors.white)
                .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
