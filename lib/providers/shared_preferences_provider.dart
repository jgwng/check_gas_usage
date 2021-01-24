import 'package:flutter_riverpod/all.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesServiceProvider =
Provider<SharedPreferencesService>((ref) => throw UnimplementedError());

class SharedPreferencesService {
  SharedPreferencesService(this.sharedPreferences);
  final SharedPreferences sharedPreferences;

  static const landingCompleteKey = 'landingComplete';

  Future<void> setLandingComplete() async {
    await sharedPreferences.setBool(landingCompleteKey, true);
  }

  bool isLandingComplete() =>
      sharedPreferences.getBool(landingCompleteKey) ?? false;
}