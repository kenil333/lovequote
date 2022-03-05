class NotificationModel {
  final int id;
  final String hour;
  final String minute;
  final String ampm;
  final bool active;

  NotificationModel({
    required this.id,
    required this.hour,
    required this.minute,
    required this.ampm,
    required this.active,
  });
}
