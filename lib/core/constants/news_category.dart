
enum NewsCategory {
  science('Science'),
  technology('Technology');

  const NewsCategory(this.label);

  final String label;

  String get apiValue => name;
}

enum StemCategory {
  science('Science', NewsCategory.science),
  technology('Technology', NewsCategory.technology),
  engineering('Engineering', NewsCategory.technology),
  mathematics('Mathematics', NewsCategory.science);

  const StemCategory(this.label, this.apiCategory);

  final String label;
  final NewsCategory apiCategory;
}