// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModelRequest _$UserModelRequestFromJson(Map<String, dynamic> json) {
  return _UserModelRequest.fromJson(json);
}

/// @nodoc
mixin _$UserModelRequest {
  String get username => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelRequestCopyWith<UserModelRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelRequestCopyWith<$Res> {
  factory $UserModelRequestCopyWith(
          UserModelRequest value, $Res Function(UserModelRequest) then) =
      _$UserModelRequestCopyWithImpl<$Res, UserModelRequest>;
  @useResult
  $Res call({String username, String password});
}

/// @nodoc
class _$UserModelRequestCopyWithImpl<$Res, $Val extends UserModelRequest>
    implements $UserModelRequestCopyWith<$Res> {
  _$UserModelRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserModelRequestImplCopyWith<$Res>
    implements $UserModelRequestCopyWith<$Res> {
  factory _$$UserModelRequestImplCopyWith(_$UserModelRequestImpl value,
          $Res Function(_$UserModelRequestImpl) then) =
      __$$UserModelRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String username, String password});
}

/// @nodoc
class __$$UserModelRequestImplCopyWithImpl<$Res>
    extends _$UserModelRequestCopyWithImpl<$Res, _$UserModelRequestImpl>
    implements _$$UserModelRequestImplCopyWith<$Res> {
  __$$UserModelRequestImplCopyWithImpl(_$UserModelRequestImpl _value,
      $Res Function(_$UserModelRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? password = null,
  }) {
    return _then(_$UserModelRequestImpl(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelRequestImpl implements _UserModelRequest {
  const _$UserModelRequestImpl(
      {required this.username, required this.password});

  factory _$UserModelRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelRequestImplFromJson(json);

  @override
  final String username;
  @override
  final String password;

  @override
  String toString() {
    return 'UserModelRequest(username: $username, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelRequestImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, username, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelRequestImplCopyWith<_$UserModelRequestImpl> get copyWith =>
      __$$UserModelRequestImplCopyWithImpl<_$UserModelRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelRequestImplToJson(
      this,
    );
  }
}

abstract class _UserModelRequest implements UserModelRequest {
  const factory _UserModelRequest(
      {required final String username,
      required final String password}) = _$UserModelRequestImpl;

  factory _UserModelRequest.fromJson(Map<String, dynamic> json) =
      _$UserModelRequestImpl.fromJson;

  @override
  String get username;
  @override
  String get password;
  @override
  @JsonKey(ignore: true)
  _$$UserModelRequestImplCopyWith<_$UserModelRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
