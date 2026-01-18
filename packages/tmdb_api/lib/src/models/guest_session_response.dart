import 'package:json_annotation/json_annotation.dart';

part 'guest_session_response.g.dart';

@JsonSerializable(createToJson: false)
class GuestSessionResponse {
  const GuestSessionResponse({
    this.success = true,
    required this.guestSessionId,
    required this.expiresAt,
  });

  final bool success;

  @JsonKey(name: 'guest_session_id')
  final String guestSessionId;

  @JsonKey(name: 'expires_at')
  final String expiresAt;

  factory GuestSessionResponse.fromJson(Map<String, dynamic> json) =>
      _$GuestSessionResponseFromJson(json);
}
