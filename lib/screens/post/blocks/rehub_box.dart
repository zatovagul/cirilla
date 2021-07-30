import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ui/badge/badge.dart';

class Box extends StatelessWidget with Utility {
  final Map<String, dynamic> block;

  const Box({Key key, this.block}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    Map attrs = get(block, ['attrs'], {}) is Map ? get(block, ['attrs'], {}) : {};
    bool takeDate = get(attrs, ['takeDate'], false);
    String textalign = get(attrs, ['textalign'], 'left');
    String type = get(attrs, ['type'], 'default');
    String content = get(attrs, ['content'], '');
    String date = get(attrs, ['date'], '');
    String label = get(attrs, ['label'], 'Update');

    TextAlign textAlign = ConvertData.toTextAlign(textalign);
    CrossAxisAlignment crossAxisAlignment = textalign == 'center'
        ? CrossAxisAlignment.center
        : textalign == 'right'
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start;

    Color background = Color(0xFFe9f7fe);
    Color textColor = Color(0xFF5091b2);
    IconData icon;
    Color iconColor;

    switch (type) {
      case 'info':
        background = Color(0xFFf0ffde);
        textColor = Color(0xFF363636);
        icon = FontAwesomeIcons.paperclip;
        iconColor = Color(0xFF53a34c);
        break;
      case 'download':
        background = Color(0xFFe8f9ff);
        textColor = Color(0xFF363636);
        icon = FontAwesomeIcons.download;
        iconColor = Color(0xFF1aa1d6);
        break;
      case 'error':
        background = Color(0xFFffd3d3);
        textColor = Color(0xFFdc0000);
        iconColor = Color(0xFFdc0000);
        icon = FeatherIcons.slash;
        break;
      case 'warning':
        background = Color(0xFFfff7f4);
        textColor = Color(0xFFa61818);
        iconColor = Color(0xFFe25b32);
        icon = FontAwesomeIcons.exclamationTriangle;
        break;
      case 'yellow':
        background = Color(0xFFfffdf3);
        textColor = Color(0xFFc4690e);
        break;
      case 'green':
        background = Color(0xFFebf6e0);
        textColor = Color(0xFF5f9025);
        break;
      case 'gray':
        background = Color(0xFFf9f9f9);
        textColor = Color(0xFF666666);
        break;
      case 'red':
        background = Color(0xFFffe9e9);
        textColor = Color(0xFFde5959);
        break;
      case 'dashed_border':
        background = Colors.transparent;
        textColor = theme.textTheme.subtitle1.color;
        break;
      case 'solid_border':
        background = Colors.transparent;
        textColor = theme.textTheme.subtitle1.color;
        break;
      case 'transparent':
        background = Colors.transparent;
        textColor = theme.textTheme.subtitle1.color;
        break;
    }

    return buildViewBox(
      theme: theme,
      borderType: type,
      background: background,
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 27, color: iconColor),
            SizedBox(
              width: 16,
            ),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: crossAxisAlignment,
              children: [
                if (takeDate) ...[
                  Badge(
                    text: Text('$date $label',
                        style: theme.textTheme.caption.copyWith(color: Colors.white, fontWeight: FontWeight.w500)),
                    color: Color(0xFF5bc0de),
                    radius: 4,
                    size: 22,
                  ),
                  SizedBox(height: 4),
                ],
                Text(content, style: theme.textTheme.bodyText1.copyWith(color: textColor), textAlign: textAlign)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildViewBox({Widget child, String borderType, Color background, ThemeData theme}) {
    switch (borderType) {
      case 'dashed_border':
        return DottedBorder(
          borderType: BorderType.RRect,
          color: theme.dividerColor,
          dashPattern: [4, 3],
          child: Container(
            color: background,
            padding: EdgeInsets.all(16),
            child: child,
          ),
        );
        break;
      default:
        Border border = borderType == 'solid_border' ? Border.all(color: theme.dividerColor) : null;
        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: background,
            border: border,
          ),
          child: child,
        );
    }
  }
}
