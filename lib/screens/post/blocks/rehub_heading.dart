import 'package:cirilla/mixins/mixins.dart';
import 'package:flutter/material.dart';

class DoubleHeading extends StatelessWidget with Utility {
  final Map<String, dynamic> block;

  const DoubleHeading({Key key, this.block}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    Map attrs = get(block, ['attrs'], {}) is Map ? get(block, ['attrs'], {}) : {};
    String content = get(attrs, ['content'], 'Heading');
    String backgroundText = get(attrs, ['backgroundText'], '01.');

    return Stack(
      children: [
        Positioned(
          child: Text(
            backgroundText,
            style: theme.textTheme.headline2.copyWith(fontWeight: FontWeight.w900, color: theme.colorScheme.surface),
          ),
        ),
        Container(
          alignment: AlignmentDirectional.centerStart,
          constraints: BoxConstraints(minHeight: 83),
          child: Text(content, style: theme.textTheme.headline6.copyWith(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
