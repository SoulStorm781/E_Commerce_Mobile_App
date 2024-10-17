import 'package:af_store/app.dart';
import 'package:af_store/data/repositories/authentication_rep/authentication_rep.dart';
import 'package:af_store/firebase_options.dart';
// import 'package:af_store/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  //Widgets Binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  setPathUrlStrategy();

  //Local Storage
  await GetStorage.init();
  // Todo: Init payment methods

  //native splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //Todo: Init Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then(
    (FirebaseApp value) => Get.put(AuthenticationRepository()),
  );

  // Todo: Initilaize Authentification
  runApp(const App());
}
