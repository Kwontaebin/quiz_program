import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'app.dart';
import 'config/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // audioplayers 6.x 전역 설정: 에셋 접두사를 'assets/'로 변경
  AudioCache.instance.prefix = 'assets/';
  
  // Initialize SharedPreferences
  await Preferences.init();
  
  runApp(const MyApp());
}
