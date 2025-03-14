import 'package:day59/models/notification/NotificationModel.dart';
import 'package:day59/providers/NotificationProvider.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final NotificationProvider _provider;

  NotificationController(this._provider);

  var notifications = <NotificationModel>[].obs;
  var _hasUnreadNotification = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeNotifications();
  }

  // Initialize notifications
  Future<void> _initializeNotifications() async {
    try {
      await _provider.initialize();
      await fetchNotifications();

      // Subscribe to foreground notifications
      _provider.subscribeToNotifications((notification) {
        addNotification(notification);
      });
    } catch (e) {
      print("Error initializing notifications: $e");
    }
  }

  // Fetch notifications from backend
  Future<void> fetchNotifications() async {
    try {
      List<NotificationModel> fetchedNotifications =
          await _provider.fetchNotifications();
      notifications.assignAll(fetchedNotifications);
    } catch (e) {
      print("Error fetching notifications: $e");
    }
  }

  // Add a notification
  void addNotification(NotificationModel notification) {
    notifications.insert(0, notification);
  }

  // Mark notification as read
  // void markAsRead(String id) {
  //   int index = notifications.indexWhere((n) => n.id == id);
  //   if (index != -1) {
  //     notifications[index] = NotificationModel(
  //       id: notifications[index].id,
  //       title: notifications[index].title,
  //       body: notifications[index].body,
  //       data: notifications[index].data,
  //       date: notifications[index].date,
  //       isRead: true,
  //     );
  //   }
  // }
  void setHasUnreadNotification(bool hasUnreadNotification) {
    _hasUnreadNotification.value = hasUnreadNotification;
  }

  // Clear all notifications
  void clearNotifications() {
    notifications.clear();
  }
}
