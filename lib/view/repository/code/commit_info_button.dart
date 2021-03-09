import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:onehub/common/profile_image.dart';
import 'package:onehub/common/provider_loading_progress_wrapper.dart';
import 'package:onehub/providers/repository/code_provider.dart';
import 'package:onehub/style/colors.dart';
import 'package:onehub/utils/get_date.dart';

class CommitInfoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderLoadingProgressWrapper<CodeProvider>(
      childBuilder: (context, value) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 16,
            ),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      '${value.tree.last.commit.commit.message.length > 20 ? value.tree.last.commit.commit.message.substring(0, 20) + '...' : value.tree.last.commit.commit.message}',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Octicons.git_commit,
                        size: 11,
                        color: AppColor.grey3,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${value.tree.last.commit.sha.substring(0, 6)}',
                        style: TextStyle(fontSize: 11, color: AppColor.grey3),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    ProfileImage(
                      value.tree.last.commit.author.avatarUrl,
                      size: 14,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      value.tree.last.commit.author.login,
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.timelapse_outlined,
                      size: 11,
                      color: AppColor.grey3,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      getDate(
                          value.tree.last.commit.commit.committer.date
                              .toString(),
                          shorten: false),
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColor.grey3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 8,
            ),
            Icon(Icons.arrow_drop_down),
            SizedBox(
              width: 3,
            ),
          ],
        );
      },
    );
  }
}