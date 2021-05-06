

class SingletonSettings {
  static final SingletonSettings _singleton = new SingletonSettings._internal();

  String? currentScreen;

  SingletonSettings._internal();

  static SingletonSettings get instance => _singleton;

  //Settings _settings;

  String? _packageVersion;
  String? _deviceModel;

  //Settings get settings => _settings;
  String? get packageVersion => _packageVersion;
  String? get deviceModel => _deviceModel;
}
