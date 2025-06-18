class Person {
  final int id;
  final String nameNe;
  final String nameEn;
  final String addressNe;
  final String addressEn;
  final String phoneNo;

  Person({
    required this.id,
    required this.nameNe,
    required this.nameEn,
    required this.addressNe,
    required this.addressEn,
    required this.phoneNo,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: int.parse(json['person_id'].toString()),
      nameNe: json['name_ne'] ?? '',
      nameEn: json['name_en'] ?? '',
      addressNe: json['address_ne'] ?? '',
      addressEn: json['address_en'] ?? '',
      phoneNo: json['phone_no'] ?? '',
    );
  }
}