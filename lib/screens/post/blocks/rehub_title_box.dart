import 'package:cirilla/mixins/mixins.dart';
import 'package:flutter/material.dart';

class TitleBox extends StatelessWidget with Utility {
  final Map<String, dynamic> block;

  const TitleBox({Key key, this.block}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    Map attrs = get(block, ['attrs'], {}) is Map ? get(block, ['attrs'], {}) : {};
    String title = get(attrs, ['title'], '');
    String text = get(attrs, ['text'], '');
    String style = get(attrs, ['style'], '1');

    Color borderColor = theme.dividerColor;
    Color titleColor = theme.textTheme.subtitle1.color;

    switch (style) {
      case '2':
        borderColor = theme.primaryColorDark;
        titleColor = theme.primaryColorDark;
        break;
      case '3':
        borderColor = Color(0xFFfb7203);
        titleColor = Color(0xFFfb7203);
        break;
      case '4':
        borderColor = theme.primaryColor;
        titleColor = theme.primaryColor;
        break;
      case '5':
        borderColor = theme.colorScheme.secondary;
        break;
      case '6':
        borderColor = theme.dividerColor;
        break;
    }

    return Stack(
      children: [
        buildBox(
          theme: theme,
          style: style,
          borderColor: borderColor,
          margin: title.isNotEmpty ? EdgeInsets.only(top: 11) : null,
          child: Text(text, style: theme.textTheme.bodyText2),
        ),
        PositionedDirectional(
          start: 12,
          child: title.isNotEmpty
              ? Container(
                  color: theme.scaffoldBackgroundColor,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    title,
                    style: theme.textTheme.subtitle1.copyWith(color: titleColor),
                    maxLines: 1,
                  ),
                )
              : Container(),
        ),
      ],
    );
  }

  Widget buildBox({ThemeData theme, String style, Widget child, EdgeInsetsGeometry margin, Color borderColor}) {
    if (style == '6') {
      return Container(
        width: double.infinity,
        margin: margin,
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(border: Border.all(width: 1, color: borderColor)),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(border: Border.all(width: 1, color: borderColor)),
          child: child,
        ),
      );
    }
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      margin: margin,
      decoration: BoxDecoration(border: Border.all(width: 3, color: borderColor)),
      child: child,
    );
  }
}
