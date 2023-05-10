package io.glassfy.glassfy_flutter

import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.glassfy.glassfy_flutter.utils.Constants
import io.glassfy.glue.GlassfyGlue

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
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity;
  }

  override fun onDetachedFromActivityForConfigChanges() {
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
      Constants.Methods.GET_PLATFORM_VERSION -> {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }
      Constants.Methods.SDK_VERSION -> {
        GlassfyGlue.sdkVersion() { v, e -> pluginCompletion(result, v, e) }
      }
      Constants.Methods.INITIALIZE -> {
        val framework: String = "flutter";
        val apiKey: String = call.argument(Constants.Parameter.API_KEY) ?: ""
        val watcherMode: Boolean = call.argument(Constants.Parameter.WATCHER_MODE) ?: false
        val version: String = call.argument(Constants.Parameter.VERSION) ?: "unknown"
        GlassfyGlue.initialize(context , apiKey, watcherMode, framework, version) { v, e -> 
          pluginCompletion(result, v, e) 
        }
      }
      Constants.Methods.SET_LOG_LEVEL -> {
        val logLevel: Int = call.argument(Constants.Parameter.LOG_LEVEL) ?: 0
        GlassfyGlue.setLogLevel(logLevel)
      }
      Constants.Methods.OFFERINGS -> {
        GlassfyGlue.offerings() { v, e -> pluginCompletion(result, v, e) }
      }
      Constants.Methods.PURCHASE_HISTORY -> {
        GlassfyGlue.purchaseHistory() { v, e -> pluginCompletion(result, v, e) }
      }
      Constants.Methods.PERMISSIONS -> {
        GlassfyGlue.permissions() { v, e -> pluginCompletion(result, v, e) }
      }
      Constants.Methods.SKU_WITH_ID -> {
        val identifier: String = call.argument(Constants.Parameter.IDENTIFIER) ?: ""
        GlassfyGlue.skuWithId(identifier) { v, e -> pluginCompletion(result, v, e) }
      }
      Constants.Methods.SKU_WITH_ID_AND_STORE -> {
        val identifier: String = call.argument(Constants.Parameter.IDENTIFIER) ?: ""
        val store: Int = call.argument(Constants.Parameter.STORE) ?: 0
        GlassfyGlue.skuWithIdAndStore(identifier,store) { v, e -> pluginCompletion(result, v, e) }
      }
      Constants.Methods.PURCHASE_SKU-> {
        val sku: HashMap<String, String>? = call.argument(Constants.Parameter.SKU)
        val skuToUpgrade: HashMap<String, Any>? = call.argument(Constants.Parameter.SKU_TO_UPGRADE)
        val skuId = sku?.get(Constants.Parameter.SKU_ID);
        var subscriptionUpdateId:String? = null
        var proration:Int? = null
        if (skuToUpgrade != null) {
          subscriptionUpdateId = skuToUpgrade.get(Constants.Parameter.SKU_ID) as String?;
          if (subscriptionUpdateId == null) {
            result.error("Invalid skuToUpgrade", null, null)
            return
          }
          proration = call.argument(Constants.Parameter.PRORATION_MODE)
        }
        if (skuId == null) {
          result.error("Invalid SKU", null, null)
          return
        }

        GlassfyGlue.purchaseSku(activity, skuId, subscriptionUpdateId,proration) { v, e -> pluginCompletion(result, v, e) }
      }
      Constants.Methods.RESTORE_PURCHASES-> {
        GlassfyGlue.restorePurchases() { v, e -> pluginCompletion(result, v, e) }
      }
      Constants.Methods.SET_DEVICE_TOKEN-> {
       // not applicable in Android
      }
      Constants.Methods.SET_EMAIL_USER_PROPERTY->{
        val email: String = call.argument(Constants.Parameter.EMAIL) ?: ""
        GlassfyGlue.setEmailUserProperty(email) { v, e -> pluginCompletion(result, v, e) }
      }
      Constants.Methods.SET_EXTRA_USER_PROPERTY->{
        val extra: Map<String, String>? = call.argument(Constants.Parameter.EXTRA_PROP)
        GlassfyGlue.setExtraUserProperty(extra) { v, e -> pluginCompletion(result, v, e) }
      }
      Constants.Methods.GET_EXTRA_USER_PROPERTY->{
        GlassfyGlue.getExtraUserProperty() { v, e -> pluginCompletion(result, v, e) }
      }
      Constants.Methods.CONNECT_CUSTOM_SUBSCRIBER->{
        val subscriberId: String? = call.argument(Constants.Parameter.SUBSCRIBER_ID)
        GlassfyGlue.connectCustomSubscriber(subscriberId) { v, e -> pluginCompletion(result, v, e) }
      }
      Constants.Methods.CONNECT_PADDLE_LICENSE_KEY->{
        val licenseKey: String = call.argument(Constants.Parameter.LICENSE_KEY) ?: ""
        val force: Boolean = call.argument(Constants.Parameter.FORCE) ?: false
        GlassfyGlue.connectPaddleLicenseKey(licenseKey, force) { v, e -> pluginCompletion(result, v, e) }
      }
      Constants.Methods.CONNECT_GLASSFY_UNIVERSAL_CODE->{
        val universalCode: String = call.argument(Constants.Parameter.UNIVERSAL_CODE) ?: ""
        val force: Boolean = call.argument(Constants.Parameter.FORCE) ?: false
        GlassfyGlue.connectGlassfyUniversalCode(universalCode, force) { v, e -> pluginCompletion(result, v, e) }
      }
      Constants.Methods.SET_ATTRIBUTION->{
        val type: Int = call.argument(Constants.Parameter.TYPE) ?: -1
        val value: String = call.argument(Constants.Parameter.VALUE) ?: ""
        GlassfyGlue.setAttribution(type,value) { v, e -> 
          pluginCompletion(result, v, e)
        }
      }
      Constants.Methods.SET_ATTRIBUTIONS->{
        val items: List<Map<String, Any?>> = call.argument(Constants.Parameter.ITEMS) ?: listOf()
        GlassfyGlue.setAttributions(items) { v, e -> pluginCompletion(result, v, e) }
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
