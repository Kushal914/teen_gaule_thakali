class EMuseumItem {
  final int id;
  final String photo;
  final String titleNe;
  final String titleEn;
  final String descNe;
  final String descEn;

  EMuseumItem({
    required this.id,
    required this.photo,
    required this.titleNe,
    required this.titleEn,
    required this.descNe,
    required this.descEn,
  });

  factory EMuseumItem.fromJson(Map<String, dynamic> json) {
    return EMuseumItem(
      id: int.parse(json['e_museum_id'].toString()),
      photo: json['e_museum_photo'] ?? '',
      titleNe: json['title_ne'] ?? '',
      titleEn: json['title_en'] ?? '',
      descNe: json['desc_ne'] ?? '',
      descEn: json['desc_en'] ?? '',
    );
  }
}