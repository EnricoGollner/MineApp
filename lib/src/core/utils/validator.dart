class Validator {
  final String text;

  Validator({required this.text});

  static String? isRequired(String? text) {
    if(text == null || text.isEmpty) {
      return "This field is required";
    }

    return null;
  }
}