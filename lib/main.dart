import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/common/utils/video_call_imports.dart';


bool isOsm = false;

String doctorKey = "Doctor"; // firebase 100
String pharmacyKey = "Pharmacy"; // firebase 127
String labKey = "Laboratory"; // firebase 147

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyCAAjeLumk9r0NNkgAAI2qjlG2cBtC1OvE',
        appId: '1:760278758699:android:b152b6555aad6ea6b3016e',
        messagingSenderId: '760278758699',
        projectId: 'medixcyapp-23f95',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  await GetStorage.init();
  await Get.putAsync<DBHelperCart>(() async {
    DBHelperCart cart = DBHelperCart();
    await cart.initDb();
    return cart;
  });

  notificationHelper.initialize();
  Stripe.publishableKey = stripePublisherKey;
  ConnectycubeFlutterCallKit.onCallAcceptedWhenTerminated =
      onCallAcceptedWhenTerminated;
  ConnectycubeFlutterCallKit.onCallRejectedWhenTerminated =
      onCallRejectedWhenTerminated;
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}
