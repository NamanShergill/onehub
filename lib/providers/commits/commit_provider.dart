import 'package:dio_hub/common/misc/base_popup_notification.dart';
import 'package:dio_hub/models/commits/commit_model.dart';
import 'package:dio_hub/providers/base_provider.dart';
import 'package:dio_hub/services/repositories/repo_services.dart';

class CommitProvider extends BaseProvider {
  CommitProvider(String? commitURL) : _commitURL = commitURL {
    if (_commitURL != null) {
      _getCommit();
    }
    statusStream.listen((event) {
      // Show a popup to retry if there was an error fetching the user details.
      if (event == Status.error) {
        showPopup(BasePopupNotification(
          title: 'Could not fetch commit details. Tap to retry.',
          dismissOnTap: false,
          notificationController: notificationController,

          // Try getting the user details again on tap.
          onTap: (context) async {
            _getCommit();
          },
        ));
        // Remove the popup if a status other than loading is set.
      } else if (event != Status.loading) {
        showPopup(null);
      }
    });
  }
  final String? _commitURL;

  CommitModel? _commit;

  CommitModel? get commit => _commit;

  void _getCommit() async {
    loading();
    try {
      _commit = await RepositoryServices.getCommit(_commitURL!);
      loaded();
    } catch (e) {
      error(error: e);
    }
  }
}
