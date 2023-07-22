import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final String? labelText;
  final IconData? icon;
  final TextEditingController? controller;
  final bool enabled;

  const CustomTextField({
    Key? key,
    required this.hint,
    this.labelText,
    this.icon,
    this.controller,
    this.enabled = true,
  }) : super(key: key);

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  late TextEditingController _textEditingController;
  late bool enabled;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _textEditingController = widget.controller ?? TextEditingController();
    enabled = widget.enabled;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    if (widget.controller == null) {
      _textEditingController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Text(
            widget.labelText!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        const SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              TextField(
                focusNode: _focusNode,
                enabled: enabled,
                controller: _textEditingController,
                autofocus: false,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  hintText: widget.hint,
                  prefixIcon: widget.icon != null
                      ? Icon(
                          widget.icon,
                          size: 18,
                        )
                      : null,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                ),
              ),
              Positioned(
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    _textEditingController.clear();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      FontAwesomeIcons.xmark,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
