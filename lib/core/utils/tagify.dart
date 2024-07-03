class Tagify {
  String createTags({required List<String> values, int? max}) {
    if (values.isNotEmpty && values.first != "") {
      final List<String> tags = values.map((value) => value.trim()).toList();

      if (max != null) {
        return "#${tags.sublist(0, max).join(" #")}";
      }

      return "#${tags.join(" #")}";
    }

    return "";
  }
}
