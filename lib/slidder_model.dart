class SlidderModel {
  String? title;
  String? description;
  String? url;

  SlidderModel({this.title, this.description, this.url});

  factory SlidderModel.fromJson(Map<String, dynamic> json) => SlidderModel(
        title: json['title'] as String?,
        description: json['description'] as String?,
        url: json['url'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'url': url,
      };
}
