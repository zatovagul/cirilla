import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:cirilla/widgets/cirilla_animation_indicator.dart';
import 'package:flutter/material.dart';

import 'rehub_conspros.dart';

class RehubReviewbox extends StatelessWidget with Utility {
  final Map<String, dynamic> block;

  const RehubReviewbox({Key key, this.block}) : super(key: key);

  Widget buildInfo(BuildContext context, {double score, String title, String description, Color colorScore}) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context).translate;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Stack(
              children: [
                CirillaAnimationIndicator(
                  value: score / 10,
                  indicatorColor: colorScore,
                  size: 72,
                  type: CirillaAnimationIndicatorType.circle,
                ),
                Container(
                  width: 72,
                  height: 72,
                  alignment: Alignment.center,
                  child: Text(score.toString(),
                      style: theme.textTheme.headline5.copyWith(fontWeight: FontWeight.w500, color: colorScore)),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(translate('post_detail_expert_score'), style: theme.textTheme.caption),
          ],
        ),
        SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: theme.textTheme.subtitle1),
              SizedBox(height: 8),
              Text(description, style: theme.textTheme.bodyText2),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildCriterias(BuildContext context, {List data, Color selectColor}) {
    ThemeData theme = Theme.of(context);

    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: IntrinsicColumnWidth(),
        1: FlexColumnWidth(),
        2: IntrinsicColumnWidth(),
      },
      children: List.generate(data.length, (index) {
        dynamic item = data.elementAt(index);
        if (item is Map) {
          String title = get(item, ['title'], '');
          double value = ConvertData.stringToDouble(get(item, ['value'], 0), 0);
          double padItem = index < data.length - 1 ? 4 : 0;
          return TableRow(
            children: [
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: buildItemBottom(
                  pad: padItem,
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 60),
                    margin: EdgeInsetsDirectional.only(end: 12),
                    child: Text(title, style: theme.textTheme.caption.copyWith(color: theme.textTheme.subtitle1.color)),
                  ),
                ),
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: buildItemBottom(
                  pad: padItem,
                  child: CirillaAnimationIndicator(
                    value: value / 10,
                    indicatorColor: selectColor,
                  ),
                ),
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: buildItemBottom(
                  pad: padItem,
                  child: Container(
                    margin: EdgeInsetsDirectional.only(start: 22),
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text(value.toString(),
                        style: theme.textTheme.caption.copyWith(color: theme.textTheme.subtitle1.color)),
                  ),
                ),
              ),
            ],
          );
        }
        return TableRow(
          children: [Container(), Container(), Container()],
        );
      }),
    );
  }

  Widget buildItemBottom({Widget child, double pad}) {
    return Container(
      padding: EdgeInsets.only(bottom: pad ?? 0),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context).translate;

    Map attrs = get(block, ['attrs'], {});

    Color mainColor = ConvertData.fromHex(get(attrs, ['mainColor'], ''), theme.primaryColor);
    String title = get(attrs, ['title'], translate('post_detail_reviewbox_title'));
    String description = get(attrs, ['description'], translate('post_detail_reviewbox_description'));
    double scoreManual = ConvertData.stringToDouble(get(attrs, ['scoreManual'], 0), 0);
    List criterias = get(attrs, ['criterias'], []);
    List positives = get(attrs, ['positives'], []);
    List negatives = get(attrs, ['negatives'], []);
    String prosTitle = get(attrs, ['prosTitle'], translate('post_detail_positive'));
    String consTitle = get(attrs, ['consTitle'], translate('post_detail_negatives'));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildInfo(context, title: title, description: description, score: scoreManual, colorScore: mainColor),
        if (criterias.length > 0)
          Padding(
            padding: EdgeInsets.only(top: 16, bottom: positives.length > 0 || negatives.length > 0 ? 14 : 0),
            child: buildCriterias(context, data: criterias, selectColor: mainColor),
          ),
        if (positives.isNotEmpty || negatives.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 32),
            child: ConsprosList(
              negatives: negatives,
              positives: positives,
              prosTitle: prosTitle,
              negaTitle: consTitle,
            ),
          ),
      ],
    );
  }

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
}
