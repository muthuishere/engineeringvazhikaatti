extension StringExtension on String {
  String toTitleCase() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}