package id.refactory.flutter_firebase

import android.os.Bundle
import com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService
import io.flutter.view.FlutterMain

class MainActivity: FlutterActivity(), PluginRegistry.PluginRegistrantCallback {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        FlutterFirebaseMessagingService.setPluginRegistrant(this)
        FlutterMain.startInitialization(this)
    }

    override fun registerWith(registry: PluginRegistry?) {
        if (registry?.hasPlugin("io.flutter.plugins.firebasemessaging") == false) {
            FirebaseMessagingPlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"))
        }
        if (registry?.hasPlugin("com.dexterous.flutterlocalnotifications") == false) {
            FlutterLocalNotificationsPlugin.registerWith(registry.registrarFor("com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin"))
        }
    }
}