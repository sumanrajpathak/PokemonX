extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  Duration getTimeDiff() {
    return DateTime.now().difference(DateTime.parse(this));
  }
}
