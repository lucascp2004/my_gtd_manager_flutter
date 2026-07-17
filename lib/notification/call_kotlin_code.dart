import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class NativeCode {
  static const _platform = MethodChannel('com.geneilsondeveloper.liveflow/kotlin_code');

  static Future<String?> getCustomPref(String key) async {
  
    final String? value = await _platform.invokeMethod('getCustomPref', {'key': key});
    return value;
  }
  static Future<void> setCustomPref(String key, String value) async{
    await _platform.invokeMethod('setCustomPref',{'key':key, 'value':value}); 
  }
  static Future<void>  initializePreferences() async{
    await _platform.invokeListMethod("initializePreferences");
  }

  static Future<void>  showNotification(int notificationId, String title, String message) async{
    debugPrint("SHOW NOTIFICATION");
    await _platform.invokeListMethod("showNotification",{'notificationId':notificationId,"title":title,"message":message});
  }

}
