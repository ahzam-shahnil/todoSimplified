import 'package:flutter/material.dart';

class TitleRow extends StatelessWidget {
  static const double _size = 86;

  const TitleRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'Todos',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: _size,
            fontWeight: FontWeight.w100,
          ),
        ),
        Icon(
          Icons.check,
          size: _size,
        )
      ],
    );
  }
}
