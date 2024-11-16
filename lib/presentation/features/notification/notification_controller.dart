import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';

import '../../../models/notification/all.dart';
import '../../base/base_controller.dart';
import '../../routing/routers/app_pages.dart';

const _boxName = 'notifications';
const _notificationsKey = 'notifications_key';
const _unreadNotificationsCountKey = 'unread_notifications_count';

class NotificationController extends BaseController with ScrollMixin {
  @override
  String get boxName => _boxName;

  final notifications = <NotificationModel>[].obs;
  RxBool hasLoadMore = true.obs;
  RxBool isLoadingLoadMore = false.obs;

  final int _pageSize = 20;
  int pageKeyLoadMore = 0;

  final RxInt _unreadNotificationsCountRx = 0.obs;
  int get unreadNotificationsCount => _unreadNotificationsCountRx.value;

  @override
  Future<void> onInit() async {
    pageKeyLoadMore = 0;
    hasLoadMore.value = true;

    await ensureInitStorage();
    _setUpPersistentStorage();

    _getUnreadNotificationsCount();

    _restoreNotifications();
    _fetchNotifications();

    super.onInit();
  }

  void _setUpPersistentStorage() {
    hydrate<int, int>(
      _unreadNotificationsCountRx,
      key: _unreadNotificationsCountKey,
    ).then((value) {
      _unreadNotificationsCountRx.value = value ?? 0;
      update();
    });
  }

  void _cacheNotifications(List<NotificationModel> notifications) {
    write(
      _notificationsKey,
      jsonEncode(
        notifications.map((notification) => notification.toJson()).toList(),
      ),
    );
  }

  void _restoreNotifications() {
    final notificationsJson = readSync(_notificationsKey);

    if (notificationsJson == null) {
      return;
    }

    final notificationsList = jsonDecode(notificationsJson) as List;

    notifications.addAll(
      notificationsList
          .map((notification) => NotificationModel.fromJson(notification))
          .toList(),
    );
  }

  void _fetchNotifications() {
    runAction(
      handleLoading: false,
      action: () async {
        await _fetchNotificationsRepository();
      },
    );
  }

  Future<void> _fetchNotificationsRepository({
    bool isLoadMore = false,
    int pageKey = 0,
  }) async {}

  void _getUnreadNotificationsCount() {}

  void increaseUnreadNotificationsCount() {
    _unreadNotificationsCountRx.value++;
    update();
  }

  void decreaseUnreadNotificationsCount() {
    if (_unreadNotificationsCountRx.value > 0) {
      _unreadNotificationsCountRx.value--;
    }

    update();
  }

  void refreshNotifications() {
    _getUnreadNotificationsCount();

    runAction(
      handleLoading: false,
      action: () async {
        await _fetchNotificationsRepository();
      },
    );
  }

  Future<void> loadMoreNotifications() async {
    await runAction(
      handleLoading: false,
      action: () async {
        if (!hasLoadMore.value) {
          return;
        }

        isLoadingLoadMore.value = true;

        pageKeyLoadMore++;
        await _fetchNotificationsRepository(
          isLoadMore: true,
          pageKey: pageKeyLoadMore,
        );

        isLoadingLoadMore.value = false;
      },
      onError: (exception) {
        isLoadingLoadMore.value = false;
      },
    );
  }

  @override
  Future<void> onEndScroll() async {
    await loadMoreNotifications();
  }

  @override
  Future<void> onTopScroll() async {}

  void _readNotification({
    required NotificationModel notification,
    required int index,
  }) {
    if (notification.isRead) {
      return;
    }

    notifications[index] = notification.copyWith(readAt: DateTime.now());
    _cacheNotifications(notifications);
    decreaseUnreadNotificationsCount();
  }

  void onTapNotification({
    required NotificationModel notification,
    required int index,
  }) {
    _readNotification(notification: notification, index: index);

    if (notification.data == null) {
      return;
    }

    return handleNotificationPayload(notification.data!);
  }

  void handleNotificationPayload(BaseNotificationPayload payload) {
    switch (payload.action) {
      case NotificationType.reactPost:
        if (payload is ReactPostNotificationPayload) {
          final int? postId = int.tryParse(payload.postId);

          _goToPostDetail(postId: postId);
        }
        break;
      case NotificationType.commentPost:
        if (payload is CommentPostNotificationPayload) {
          final int? postId = int.tryParse(payload.postId);

          _goToPostDetail(postId: postId, isShowComment: true);
        }
        break;
      case NotificationType.reactComment:
        if (payload is ReactCommentNotificationPayload) {
          final int? postId = int.tryParse(payload.postId);

          _goToPostDetail(postId: postId, isShowComment: true);
        }
        break;
      default:
        break;
    }
  }

  void _goToPostDetail({int? postId, bool isShowComment = false}) {
    if (postId == null) {
      return;
    }

    Get.toNamed(
      Routes.postDetail,
      arguments: {
        'postId': postId,
        'isShowComment': isShowComment,
      },
    );
  }
}
