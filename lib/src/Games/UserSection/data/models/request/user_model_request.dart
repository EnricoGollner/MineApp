import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model_request.freezed.dart';
part 'user_model_request.g.dart';

@freezed
class UserModelRequest with _$UserModelRequest {
  const factory UserModelRequest({
    required String username,
    required String password,
  }) = _UserModelRequest;

  factory UserModelRequest.fromJson(Map<String, dynamic> map) => _$UserModelRequestFromJson(map);
} 