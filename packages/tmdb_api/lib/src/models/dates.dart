import 'package:json_annotation/json_annotation.dart';

part 'dates.g.dart';

@JsonSerializable(createToJson: false)
class Dates {
  Dates({
    required this.maximum,
    required this.minimum,
  });

  final DateTime? maximum;
  final DateTime? minimum;

  Dates copyWith({
    DateTime? maximum,
    DateTime? minimum,
  }) {
    return Dates(
      maximum: maximum ?? this.maximum,
      minimum: minimum ?? this.minimum,
    );
  }

  factory Dates.fromJson(Map<String, dynamic> json) => _$DatesFromJson(json);

  @override
  String toString() {
    return '$maximum, $minimum';
  }
}
