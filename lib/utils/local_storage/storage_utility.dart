import 'package:get_storage/get_storage.dart';

class FLocalStorage {
  late final GetStorage _storage;

  static FLocalStorage? _instance;

  FLocalStorage._internal();

  factory FLocalStorage.instance() {
    _instance ??= FLocalStorage._internal();
    return _instance!;
  }

  static Future<void> init(String bucketName) async {
    await GetStorage.init(bucketName);
    _instance = FLocalStorage._internal();
    _instance!._storage = GetStorage(bucketName);
  }

  //Generic method to save data
  Future<void> writeData<F>(String key, F value) async {
    await _storage.write(key, value);
  }

  //Generic method to read data
  F? readData<F>(String key) {
    return _storage.read<F>(key);
  }

  //Generic method to remove data
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  //Clear all data
  Future<void> clearAllData() async {
    await _storage.erase();
  }
}
