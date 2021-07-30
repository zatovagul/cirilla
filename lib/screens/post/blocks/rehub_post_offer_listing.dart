import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/screens/post/post.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:cirilla/widgets/cirilla_cache_image.dart';
import 'package:flutter/material.dart';
import 'package:ui/badge/badge.dart';

class PostOfferListing extends StatelessWidget with Utility {
  final Map<String, dynamic> block;

  const PostOfferListing({Key key, this.block}) : super(key: key);

  void goDetail(BuildContext context, dynamic id) {
    if (id != null) {
      Navigator.of(context).pushNamed(PostScreen.routeName, arguments: {
        'id': ConvertData.stringToInt(id),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Map attrs = get(block, ['attrs'], {}) is Map ? get(block, ['attrs'], {}) : {};
    List selectPosts = get(attrs, ['selectedPosts'], []);
    List offers = get(attrs, ['offers'], []);

    if (offers.isEmpty) {
      return Container();
    }

    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 5,
      child: Table(
        columnWidths: {
          0: IntrinsicColumnWidth(),
          1: FlexColumnWidth(),
          2: IntrinsicColumnWidth(),
        },
        border: TableBorder.symmetric(inside: BorderSide(color: theme.dividerColor)),
        children: List.generate(offers.length, (index) {
          Map offer = offers.elementAt(index);
          double score = ConvertData.stringToDouble(get(offer, ['score'], 0));
          String linkUrl = get(offer, ['thumbnail', 'url'], '');
          String title = get(offer, ['title'], '');
          String copy = get(offer, ['copy'], '');
          String readMore = get(offer, ['readMore'], '');
          dynamic idPost = index < selectPosts.length ? selectPosts.elementAt(index) : null;

          return TableRow(
            children: [
              buildBoxPad(
                child: buildImage(theme: theme, image: linkUrl, score: score, onClick: () => goDetail(context, idPost)),
              ),
              buildBoxPad(
                child:
                    buildContent(theme: theme, title: title, subTitle: copy, onClick: () => goDetail(context, idPost)),
              ),
              buildBoxPad(
                child: buildButton(theme: theme, textButton: readMore, onClick: () => goDetail(context, idPost)),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget buildImage({ThemeData theme, String image, double score, Function onClick}) {
    double width = 80;
    double height = (width * 63) / 119;
    return InkWell(
      onTap: onClick,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CirillaCacheImage(image, width: width, height: height),
          ),
          PositionedDirectional(
            top: 8,
            end: 8,
            child: score > 0
                ? Badge(
                    text: Text(
                      score.toString(),
                      style: theme.textTheme.overline.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    size: 18,
                    color: theme.primaryColor,
                  )
                : Container(),
          )
        ],
      ),
    );
  }

  Widget buildContent({ThemeData theme, String title, String subTitle, Function onClick}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onClick,
          child: Text(
            title ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.subtitle1,
          ),
        ),
        SizedBox(height: 8),
        Text(
          subTitle ?? '',
          style: theme.textTheme.caption,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget buildButton({ThemeData theme, String textButton, Function onClick}) {
    return Container(
      constraints: BoxConstraints(maxWidth: 80),
      child: TextButton(
        onPressed: onClick,
        child: Text(
          textButton,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget buildBoxPad({Widget child, double pad}) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(padding: EdgeInsets.all(pad ?? 12), child: child),
    );
  }
}
