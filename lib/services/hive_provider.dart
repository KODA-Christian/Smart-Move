import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

class HiveProvider {
  // returns a new Hive instance (key-value database)
  // generates a new encryption key if no box exists or a dead key existed
  // the encryption key is saved by secure storage
  static Future<Box> getEncryptedBox(
      {required String boxName, required String boxKeyName}) async {
    String? key = await const FlutterSecureStorage().read(key: boxKeyName);

    if (key == null) {
      await Hive.deleteBoxFromDisk(boxName);
    } // delete box if exists

    if (!(await Hive.boxExists(boxName))) {
      key = null;
    } // generate new key if no box exists

    List<int> seq;
    if (key == null) {
      seq = Hive.generateSecureKey();
      await const FlutterSecureStorage()
          .write(key: boxKeyName, value: base64UrlEncode(seq));
    } else {
      seq = base64Url.decode(key);
    }

    try {
      return await Hive.openBox(boxName, encryptionCipher: HiveAesCipher(seq));
    } catch (e) {
      // encryption key is wrong... Generate new key and box
      await const FlutterSecureStorage().delete(key: boxKeyName);
      await Hive.deleteBoxFromDisk(boxName);
      return await getEncryptedBox(boxName: boxName, boxKeyName: boxKeyName);
    }
  }
}
