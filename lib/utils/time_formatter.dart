class TimeFormatter {
  static String formatDurationIso8601(String raw) {
    final regex = RegExp(r'^PT(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?$');
    final match = regex.firstMatch(raw);

    if (match == null) return raw;

    final hours = match.group(1);
    final minutes = match.group(2);
    final seconds = match.group(3);

    final parts = <String>[];

    if (hours != null) {
      parts.add('${int.parse(hours)}h');
    }

    if (minutes != null) {
      parts.add('${int.parse(minutes)}m');
    }

    if (seconds != null && parts.isEmpty) {
      parts.add('${int.parse(seconds)}s');
    }

    return parts.join(' ');
  }
}
