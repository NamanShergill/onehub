import 'package:dio_hub/common/misc/bottom_sheet.dart';
import 'package:dio_hub/controller/deep_linking_handler.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void linkHandler(BuildContext context, String? url,
    {String? shareDescription, bool showSheetOnDeepLink = false}) async {
  if (isDeepLink(url!) && !showSheetOnDeepLink) {
    deepLinkNavigate(url);
  } else {
    final canLaunchLink = await canLaunch(url);
    if (canLaunchLink) {
      showURLBottomActionsMenu(context, url,
          shareDescription: shareDescription, showOpenTile: !isDeepLink(url));
    }
  }
}
