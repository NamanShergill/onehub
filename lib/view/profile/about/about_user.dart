import 'package:dio_hub/app/settings/palette.dart';
import 'package:dio_hub/common/misc/info_card.dart';
import 'package:dio_hub/models/users/user_info_model.dart';
import 'package:dio_hub/utils/get_date.dart';
import 'package:dio_hub/utils/link_handler.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class AboutUser extends StatelessWidget {
  const AboutUser(this.userInfoModel, {Key? key}) : super(key: key);
  final UserInfoModel? userInfoModel;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          if (userInfoModel!.bio != null)
            InfoCard(
              'Bio',
              child: Row(
                children: [
                  Flexible(child: Text(userInfoModel!.bio!)),
                ],
              ),
            ),
          if (userInfoModel!.twitterUsername != null)
            InfoCard(
              'Twitter',
              onTap: () {
                linkHandler(context,
                    'https://twitter.com/${userInfoModel!.twitterUsername}');
              },
              child: Row(
                children: [
                  Icon(
                    LineIcons.twitter,
                    color: Provider.of<PaletteSettings>(context)
                        .currentSetting
                        .faded3,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text('@${userInfoModel!.twitterUsername}'),
                ],
              ),
            ),
          if (userInfoModel!.email != null)
            InfoCard(
              'Email',
              onTap: () {
                linkHandler(context, 'mailto:${userInfoModel!.email}');
              },
              child: Row(
                children: [
                  Icon(
                    LineIcons.at,
                    color: Provider.of<PaletteSettings>(context)
                        .currentSetting
                        .faded3,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(userInfoModel!.email!),
                ],
              ),
            ),
          if (userInfoModel!.blog != null && userInfoModel!.blog!.isNotEmpty)
            InfoCard(
              'Blog',
              onTap: () {
                linkHandler(context, userInfoModel!.blog);
              },
              child: Row(
                children: [
                  Icon(
                    LineIcons.blog,
                    color: Provider.of<PaletteSettings>(context)
                        .currentSetting
                        .faded3,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Flexible(child: Text(userInfoModel!.blog!)),
                ],
              ),
            ),
          if (userInfoModel!.company != null)
            InfoCard(
              'Company',
              child: Row(
                children: [
                  Icon(
                    LineIcons.building,
                    color: Provider.of<PaletteSettings>(context)
                        .currentSetting
                        .faded3,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(userInfoModel!.company!),
                ],
              ),
            ),
          if (userInfoModel!.location != null)
            InfoCard(
              'Location',
              child: Row(
                children: [
                  Icon(
                    LineIcons.locationArrow,
                    color: Provider.of<PaletteSettings>(context)
                        .currentSetting
                        .faded3,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(userInfoModel!.location!),
                ],
              ),
            ),
          if (userInfoModel!.createdAt != null)
            InfoCard(
              'Joined',
              child: Row(
                children: [
                  Icon(
                    LineIcons.calendar,
                    color: Provider.of<PaletteSettings>(context)
                        .currentSetting
                        .faded3,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(getDate(userInfoModel!.createdAt.toString(),
                      shorten: false)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
