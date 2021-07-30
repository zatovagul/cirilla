import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/widgets/cirilla_cache_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SliderBlock extends StatelessWidget with Utility {
  final Map<String, dynamic> block;

  const SliderBlock({Key key, this.block}) : super(key: key);

  List<String> convertData(List data) {
    List<String> result = [];
    for (var i = 0; i < data.length; i++) {
      dynamic item = data.elementAt(i);
      String image = item is Map ? get(item, ['image', 'url'], '') : '';
      if (image.isNotEmpty) {
        result.add(image);
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    Map attrs = get(block, ['attrs'], {}) is Map ? get(block, ['attrs'], {}) : {};
    List slides = get(attrs, ['slides'], []);
    List<String> data = convertData(slides);

    if (data.isEmpty) {
      return Container();
    }

    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        double width = constraints.maxWidth;
        double height = (width * 340) / 760;
        print(height);
        return SizedBox(
          width: width,
          height: height,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return CirillaCacheImage(
                data.elementAt(index),
                width: width,
                height: height,
                fit: BoxFit.contain,
              );
            },
            itemCount: data.length,
            itemWidth: width,
            itemHeight: height,
            control: new SwiperControl(padding: EdgeInsets.all(8), size: 25, color: theme.primaryColor),
            pagination: SwiperCustomPagination(builder: (_, SwiperPluginConfig config) {
              int activeVisit = config?.activeIndex ?? 0;
              return Align(
                alignment: AlignmentDirectional.bottomStart,
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: List.generate(data.length, (index) {
                      double size = activeVisit == index ? 10 : 6;
                      Color color = activeVisit == index ? theme.primaryColor : theme.dividerColor;
                      return Container(
                        width: size,
                        height: size,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
