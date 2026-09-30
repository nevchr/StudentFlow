import 'dart:convert';
import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract interface class DatabaseKeyStore {
  Future<String> getOrCreateKey();

  Future<void> deleteKey();
}

/// Stores only the random database key in platform-protected storage. Financial
/// records remain in the encrypted SQLite database.
final class PlatformDatabaseKeyStore implements DatabaseKeyStore {
  PlatformDatabaseKeyStore({FlutterSecureStorage? storage})
    : _storage =
          storage ??
          const FlutterSecureStorage(
            aOptions: AndroidOptions(migrateWithBackup: true),
          );

  static const _storageKey = 'studentflow.database-key.v1';
  final FlutterSecureStorage _storage;

  @override
  Future<String> getOrCreateKey() async {
    final existing = await _storage.read(key: _storageKey);
    if (existing != null && existing.isNotEmpty) return existing;

    final random = Random.secure();
    final bytes = List<int>.generate(32, (_) => random.nextInt(256));
    final key = base64UrlEncode(bytes);
    await _storage.write(key: _storageKey, value: key);
    return key;
  }

  @override
  Future<void> deleteKey() => _storage.delete(key: _storageKey);
}

final class InMemoryDatabaseKeyStore implements DatabaseKeyStore {
  InMemoryDatabaseKeyStore([this._key = 'test-only-database-key']);

  String? _key;

  @override
  Future<String> getOrCreateKey() async =>
      _key ??= 'replacement-test-only-database-key';

  @override
  Future<void> deleteKey() async => _key = null;
}
