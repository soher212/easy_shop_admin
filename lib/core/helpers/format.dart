String formatPrice(double value) {
  return value == value.truncateToDouble()
      ? value.toStringAsFixed(0)
      : value.toStringAsFixed(2);
}

String formatDateTime(DateTime date) {
  final hour12 = date.hour % 12 == 0 ? 12 : date.hour % 12;
  final minutes = date.minute.toString().padLeft(2, '0');
  final period = date.hour < 12 ? 'AM' : 'PM';
  return '${formatDate(date)} · ${hour12.toString().padLeft(2, '0')}:$minutes $period';
}

String formatDate(DateTime date) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return '${months[date.month - 1]} ${date.day}, ${date.year}';
}
