import 'package:cirilla/constants/assets.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ReviewHeading extends StatelessWidget with Utility {
  final Map<String, dynamic> block;

  const ReviewHeading({Key key, this.block}) : super(key: key);

  void openUrl(String url) {
    if (url != null && url.isNotEmpty) {
      launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    Map attrs = get(block, ['attrs'], {}) is Map ? get(block, ['attrs'], {}) : {};
    bool enablePosition = get(attrs, ['includePosition'], true);
    bool enableImage = get(attrs, ['includeImage'], true);
    String titlePosition = get(attrs, ['position'], '1');
    String title = get(attrs, ['title'], '');
    String subtitle = get(attrs, ['subtitle'], '');
    String image = get(attrs, ['image', 'url'], Assets.noImageUrl);
    String link = get(attrs, ['link'], '');

    return Row(
      children: [
        if (enablePosition) ...[
          Container(
            constraints: BoxConstraints(maxWidth: 150),
            child: Text(
              '$titlePosition.',
              style: theme.textTheme.headline2.copyWith(fontWeight: FontWeight.w900),
            ),
          ),
          SizedBox(width: 16),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: theme.textTheme.headline6),
              Text(subtitle, style: theme.textTheme.bodyText2),
            ],
          ),
        ),
        if (enableImage) ...[
          SizedBox(height: 16),
          InkWell(
            onTap: () => openUrl(link),
            child: Image.network(image, width: 60),
          ),
        ],
      ],
    );
  }
}
