import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class ConsPros extends StatelessWidget with Utility {
  final Map<String, dynamic> block;

  const ConsPros({Key key, this.block}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context).translate;

    Map attrs = get(block, ['attrs'], {}) is Map ? get(block, ['attrs'], {}) : {};
    List positives = get(attrs, ['positives'], []);
    List negatives = get(attrs, ['negatives'], []);
    String prosTitle = get(attrs, ['prosTitle'], translate('post_detail_positive'));
    String consTitle = get(attrs, ['consTitle'], translate('post_detail_negatives'));
    return ConsprosList(
      positives: positives,
      negatives: negatives,
      prosTitle: prosTitle,
      negaTitle: consTitle,
    );
  }
}

class ConsprosList extends StatelessWidget {
  final List positives;
  final List negatives;
  final String prosTitle;
  final String negaTitle;
  ConsprosList({
    Key key,
    @required this.positives,
    @required this.negatives,
    this.prosTitle,
    this.negaTitle,
  }) : super(key: key);

  List<String> convertData(List data) {
    List<String> results = [];
    for (var i = 0; i < data.length; i++) {
      dynamic value = data.elementAt(i);
      if (value is String) {
        results.add(value);
      }
      if (value is Map && get(value, ['title'], '') != '') {
        results.add(get(value, ['title'], ''));
      }
    }
    return results;
  }

  @override
  Widget build(BuildContext context) {
    List<String> dataPositives = convertData(positives);
    List<String> dataNegatives = convertData(negatives);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (dataPositives.isNotEmpty)
          buildViewIcon(
            context,
            title: prosTitle,
            data: dataPositives,
            color: Color(0xFF21BA45),
            icon: FeatherIcons.checkCircle,
          ),
        if (dataNegatives.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: dataPositives.isNotEmpty ? 32 : 0),
            child: buildViewIcon(
              context,
              title: negaTitle,
              data: dataNegatives,
              color: Color(0xFFF01F0E),
              icon: FeatherIcons.x,
            ),
          ),
      ],
    );
  }

  Widget buildViewIcon(BuildContext context, {List<String> data, String title, IconData icon, Color color}) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null && title.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text(title, style: theme.textTheme.subtitle1.copyWith(color: color)),
          ),
        ...List.generate(data.length, (index) {
          String value = data.elementAt(index);
          return buildItemBottom(
              child: Row(
                children: [
                  Icon(icon, size: 16, color: color),
                  SizedBox(width: 10),
                  Expanded(
                    child:
                        Text(value, style: theme.textTheme.bodyText2.copyWith(color: theme.textTheme.subtitle1.color)),
                  ),
                ],
              ),
              pad: index < data.length - 1 ? 8 : 0);
        })
      ],
    );
  }

  Widget buildItemBottom({Widget child, double pad}) {
    return Container(
      padding: EdgeInsets.only(bottom: pad ?? 0),
      child: child,
    );
  }
}
