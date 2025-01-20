import 'package:dio/dio.dart';
import 'package:tradelog_flutter/secrets.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/authentication/account_credentials_dto.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/authentication/login_account_dto.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/authentication/register_account_dto.dart';
import 'package:tradelog_flutter/src/core/data/services/api_service.dart';

class AuthenticationService extends ApiService {
  AuthenticationService({
    super.baseUrl = '${apiUrl}users/',
    super.authenticated = false,
  });

  Future<void> logout() async {
    await clearTokens();
  }

  Future<AccountCredentialsDto?> login(LoginAccountDto dto) async {
    Response response = await post(
      'token/',
      body: dto.toJson(),
    );

    if (response.statusCode == 200) {
      AccountCredentialsDto credentialsDto = AccountCredentialsDto.fromJson(
        response.data,
      );

      await setTokens(credentialsDto.accessToken, credentialsDto.refreshToken);

      return credentialsDto;
    }

    return null;
  }

  Future<AccountCredentialsDto?> register(RegisterAccountDto dto) async {
    Response response = await post(
      'register/',
      body: dto.toJson(),
    );

    if (response.statusCode == 201) {
      return await login(
        LoginAccountDto(
          email: dto.email,
          password: dto.password,
        ),
      );
    }

    return null;
  }
}
