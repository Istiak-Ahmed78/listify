extension StringNullOrEmpty on String? {
  bool get isNullOrEmpty => this == null || (this?.isEmpty ?? true);
}
