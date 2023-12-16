class ApiModel {
  final String id;
  final String title;
  final String description;
  final String is_completed;
  final String created_date;
  final String updated_date;

  ApiModel({
    required this.id,
    required this.title,
    required this.description,
    required this.is_completed,
    required this.created_date,
    required this.updated_date,
  });
}
