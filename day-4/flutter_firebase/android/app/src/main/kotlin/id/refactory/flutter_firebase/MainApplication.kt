package id.refactory.flutter_firebase

import android.content.Context
import androidx.multidex.MultiDex
import com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin
import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingPlugin
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingBackgroundService;

class MainApplication : FlutterApplication(), PluginRegistrantCallback {
    override fun onCreate() {
        super.onCreate()
        FlutterFirebaseMessagingBackgroundService.setPluginRegistrant(this)
    }

    override fun attachBaseContext(base: Context) {
        super.attachBaseContext(base)
        MultiDex.install(this)
    }

    override fun registerWith(registry: PluginRegistry?) {
        FlutterFirebaseMessagingPlugin.registerWith(registry?.registrarFor("io.flutter.plugins.firebase.messaging.FirebaseMessagingPlugin"))
        FlutterLocalNotificationsPlugin.registerWith(registry?.registrarFor("com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin"))
    }
}