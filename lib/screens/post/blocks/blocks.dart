import 'package:cirilla/screens/post/blocks/core_quote.dart';
import 'package:flutter/material.dart';

import 'core_paragraph.dart';
import 'core_image.dart';
import 'core_gallery.dart';
import 'core_embed.dart';
import 'core_video.dart';
import 'core_columns.dart';
import 'rehub_box.dart';
import 'rehub_offerbox.dart';
import 'rehub_reviewbox.dart';
import 'rehub_comparison_table.dart';
import 'rehub_post_offer_listing.dart';
import 'rehub_title_box.dart';
import 'rehub_heading.dart';
import 'rehub_accordion.dart';
import 'rehub_conspros.dart';
import 'rehub_post_offerbox.dart';
import 'rehub_review_heading.dart';
import 'rehub_itinerary.dart';
import 'rehub_slider.dart';
import 'core_heading.dart';
import 'core_quote.dart';
import 'core_list.dart';
import 'core_audio.dart';
import 'core_cover.dart';
import 'core_social_icon.dart';
import 'core_media_text.dart';

class PostBlock extends StatelessWidget {
  static const String paragraph = 'core/paragraph';
  static const String gallery = 'core/gallery';
  static const String image = 'core/image';
  static const String embed = 'core/embed';
  static const String video = 'core/video';
  static const String columns = 'core/columns';
  static const String box = 'rehub/box';
  static const String offerbox = 'rehub/offerbox';
  static const String reviewbox = 'rehub/reviewbox';
  static const String comparisonTable = 'rehub/comparison-table';
  static const String postOfferListing = 'rehub/post-offer-listing';
  static const String titleBox = 'rehub/titlebox';
  static const String doubleHeading = 'rehub/heading';
  static const String accordion = 'rehub/accordion';
  static const String conspros = 'rehub/conspros';
  static const String postOfferbox = 'rehub/post-offerbox';
  static const String reviewHeading = 'rehub/review-heading';
  static const String itinerary = 'rehub/itinerary';
  static const String slider = 'rehub/slider';
  static const String heading = 'core/heading';
  static const String quote = 'core/quote';
  static const String list = 'core/list';
  static const String audio = 'core/audio';
  static const String cover = 'core/cover';
  static const String social = 'core/social-links';
  static const String mediaText = 'core/media-text';

  final Map<String, dynamic> block;

  const PostBlock({Key key, this.block}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (block['blockName']) {
      case paragraph:
        return Paragraph(block: block);
      case image:
        return BlockImage(block: block);
      case gallery:
        return BlockGallery(block: block);
      case embed:
        return Embed(block: block);
      case video:
        return Video(block: block);
      case columns:
        return Columns(block: block);
      case offerbox:
        return RehubOfferbox(block: block);
      case reviewbox:
        return RehubReviewbox(block: block);
      case heading:
        return Heading(block: block);
      case quote:
        return Quote(block: block);
      case list:
        return ListBlock(block: block);
      case cover:
        return Cover(block: block);
      case social:
        return Social(block: block);
      case comparisonTable:
        return RehubComparisonTable(block: block);
      case postOfferListing:
        return PostOfferListing(block: block);
      case box:
        return Box(block: block);
      case titleBox:
        return TitleBox(block: block);
      case doubleHeading:
        return DoubleHeading(block: block);
      case accordion:
        return Accordion(block: block);
      case conspros:
        return ConsPros(block: block);
      case postOfferbox:
        return PostOfferbox(block: block);
      case reviewHeading:
        return ReviewHeading(block: block);
      case itinerary:
        return Itinerary(block: block);
      case slider:
        return SliderBlock(block: block);
      case audio:
        return Audio(block: block);
      case mediaText:
        return MediaText(block: block);
      default:
        return Paragraph(block: block);
    }
  }
}
