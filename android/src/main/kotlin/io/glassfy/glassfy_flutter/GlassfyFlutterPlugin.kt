package io.glassfy.glassfy_flutter

import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.glassfy.glue.GlassfyGlue
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

/** GlassfyFlutterPlugin */
class GlassfyFlutterPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  var ctx: Context? = null;

  private lateinit var context: Context
  private lateinit var activity: Activity

  override fun onDetachedFromActivity() {
    TODO("Not yet implemented")
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    TODO("Not yet implemented")
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity;
  }

  override fun onDetachedFromActivityForConfigChanges() {
    TODO("Not yet implemented")
  }


  private fun pluginCompletion(@NonNull result: Result, value: String?, error: String?) {
    if (error != null) {
      result.error(error,null,null)
      return
    }
    result.success(value)
  }
  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext

    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "glassfy_flutter")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {

    when (call.method) {
      "getPlatformVersion" -> {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }
      "sdkVersion" -> {
        GlassfyGlue.sdkVersion() { v, e -> pluginCompletion(result, v, e) }
      }
      "initialize" -> {
        val apiKey: String = call.argument("apiKey") ?: ""
        val watcherMode: Boolean = call.argument("watcherMode") ?: false

        GlassfyGlue.initialize(context , apiKey, watcherMode) { v, e -> pluginCompletion(result, v, e) }
      }
      "offerings" -> {
        GlassfyGlue.offerings() { v, e -> pluginCompletion(result, v, e) }
      }
      "permissions" -> {
        GlassfyGlue.permissions() { v, e -> pluginCompletion(result, v, e) }
      }
      "skuWithId" -> {
        val identifier: String = call.argument("identifier") ?: ""
        GlassfyGlue.skuWithId(identifier) { v, e -> pluginCompletion(result, v, e) }
      }
      "skuWithIdAndStore" -> {
        val identifier: String = call.argument("identifier") ?: ""
        val store: Int = call.argument("store") ?: 0
        GlassfyGlue.skuWithIdAndStore(identifier,store) { v, e -> pluginCompletion(result, v, e) }
      }
      "purchaseSku"-> {
        val sku:HashMap<String, String>? = call.argument("sku")
        if (sku != null) {
          sku["skuId"]?.let { GlassfyGlue.purchaseSku(activity, it) { v, e -> pluginCompletion(result, v, e) } }
        }
      }
      "restorePurchases"-> {
        GlassfyGlue.restorePurchases() { v, e -> pluginCompletion(result, v, e) }
      }
      "setDeviceToken"-> {
       // not applicable in Android
      }
      "setEmailUserProperty"->{
        val email: String = call.argument("email") ?: ""
        GlassfyGlue.setEmailUserProperty(email) { v, e -> pluginCompletion(result, v, e) }
      }
      "setExtraUserProperty"->{
        val extra: Map<String, String>? = call.argument("extraProp")
        GlassfyGlue.setExtraUserProperty(extra) { v, e -> pluginCompletion(result, v, e) }
      }
      "getExtraUserProperty"->{
        GlassfyGlue.getExtraUserProperty() { v, e -> pluginCompletion(result, v, e) }
      }
      "connectCustomSubscriber"->{
        val subscriberId: String? = call.argument("subscriberId")
        GlassfyGlue.connectCustomSubscriber(subscriberId) { v, e -> pluginCompletion(result, v, e) }
      }
      "connectPaddleLicenseKey"->{
        val licenseKey: String = call.argument("licenseKey") ?: ""
        val force: Boolean = call.argument("force") ?: false
        GlassfyGlue.connectPaddleLicenseKey(licenseKey,force) { v, e -> pluginCompletion(result, v, e) }
      }
     else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
