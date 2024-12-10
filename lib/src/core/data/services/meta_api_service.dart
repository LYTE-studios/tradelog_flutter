import 'package:tradelog_flutter/secrets.dart';
import 'package:tradelog_flutter/src/core/data/services/api_service.dart';

class MetaApiService extends ApiService {
  MetaApiService({
    super.baseUrl = '${apiUrl}metatrade/',
  });
}
