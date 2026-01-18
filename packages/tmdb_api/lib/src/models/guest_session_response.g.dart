// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guest_session_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuestSessionResponse _$GuestSessionResponseFromJson(
  Map<String, dynamic> json,
) => GuestSessionResponse(
  success: json['success'] as bool? ?? true,
  guestSessionId: json['guest_session_id'] as String,
  expiresAt: json['expires_at'] as String,
);
