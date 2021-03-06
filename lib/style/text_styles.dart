import 'package:dio_hub/app/settings/palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppThemeTextStyles {
  static TextStyle appBarTitle(BuildContext context) =>
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
  static TextStyle eventCardHeaderBold(BuildContext context) =>
      const TextStyle(fontWeight: FontWeight.bold);
  static TextStyle eventCardHeaderMed(BuildContext context) =>
      const TextStyle();
  static TextStyle eventCardChildTitle(BuildContext context) =>
      const TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
  static TextStyle eventCardChildTitleSmall(BuildContext context) =>
      const TextStyle(fontSize: 12);
  static TextStyle eventCardChildSubtitle(BuildContext context) =>
      const TextStyle(fontSize: 13);
  static TextStyle eventCardChildFooter(BuildContext context) => TextStyle(
      fontSize: 11,
      color: Provider.of<PaletteSettings>(context).currentSetting.faded3);
  static TextStyle basicIssueEventCardText(BuildContext context) => TextStyle(
      color: Provider.of<PaletteSettings>(context).currentSetting.faded3);
}
