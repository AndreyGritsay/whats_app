import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _Keys {
  static const tokenId = 'token-id';
}

class SecurityStorage {
  static const _securityStorage = FlutterSecureStorage();

  Future<String?> getTokenId() => _securityStorage.read(key: _Keys.tokenId);

  Future<void> setTokenId(String? value) {
    if (value != null) {
      return _securityStorage.write(key: _Keys.tokenId, value: value);
    } else {
      return _securityStorage.delete(key: _Keys.tokenId);
    }
  }
}
