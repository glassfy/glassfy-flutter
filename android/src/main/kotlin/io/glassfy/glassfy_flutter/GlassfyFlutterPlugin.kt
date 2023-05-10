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
      Constants.Methods.sdkVersion -> {
        GlassfyGlue.sdkVersion() { v, e -> pluginCompletion(result, v, e) }
      }
      Constants.Methods.initialize -> {
        val framework: String = "flutter";
        val apiKey: String = call.argument(Constants.Parameter.apiKey) ?: ""
        val watcherMode: Boolean = call.argument(Constants.Parameter.watcherMode) ?: false
        val version: String = call.argument(Constants.Parameter.version) ?: "unknown"
        GlassfyGlue.initialize(context , apiKey, watcherMode, framework, version) { v, e -> 
          pluginCompletion(result, v, e) 
        }
      }
      Constants.Methods.setLogLevel -> {
        val logLevel: Int = call.argument(Constants.Parameter.logLevel) ?: 0
        GlassfyGlue.setLogLevel(logLevel)
      }
      Constants.Methods.offerings -> {
        GlassfyGlue.offerings() { v, e -> pluginCompletion(result, v, e) }
      }
      Constants.Methods.purchaseHistory -> {
        GlassfyGlue.purchaseHistory() { v, e -> pluginCompletion(result, v, e) }
      }
      Constants.Methods.permissions -> {
        GlassfyGlue.permissions() { v, e -> pluginCompletion(result, v, e) }
      }
      Constants.Methods.skuWithId -> {
        val identifier: String = call.argument(Constants.Parameter.identifier) ?: ""
        GlassfyGlue.skuWithId(identifier) { v, e -> pluginCompletion(result, v, e) }
      }
      Constants.Methods.skuWithIdAndStore -> {
        val identifier: String = call.argument(Constants.Parameter.identifier) ?: ""
        val store: Int = call.argument(Constants.Parameter.store) ?: 0
        GlassfyGlue.skuWithIdAndStore(identifier,store) { v, e -> pluginCompletion(result, v, e) }
      }
      Constants.Methods.purchaseSku-> {
        val sku: HashMap<String, String>? = call.argument(Constants.Parameter.sku)
        val skuToUpgrade: HashMap<String, Any>? = call.argument(Constants.Parameter.skuToUpgrade)
        val skuId = sku?.get(Constants.Parameter.skuId);
        var subscriptionUpdateId:String? = null
        var proration:Int? = null
        if (skuToUpgrade != null) {
          subscriptionUpdateId = skuToUpgrade.get(Constants.Parameter.skuId) as String?;
          if (subscriptionUpdateId == null) {
            result.error("Invalid skuToUpgrade", null, null)
            return
          }
          proration = call.argument(Constants.Parameter.prorationMode)
        }
        if (skuId == null) {
          result.error("Invalid SKU", null, null)
          return
        }

        GlassfyGlue.purchaseSku(activity, skuId, subscriptionUpdateId,proration) { v, e -> pluginCompletion(result, v, e) }
      }
      Constants.Methods.restorePurchases-> {
        GlassfyGlue.restorePurchases() { v, e -> pluginCompletion(result, v, e) }
      }
      Constants.Methods.setDeviceToken-> {
       // not applicable in Android
      }
      Constants.Methods.setEmailUserProperty->{
        val email: String = call.argument(Constants.Parameter.email) ?: ""
        GlassfyGlue.setEmailUserProperty(email) { v, e -> pluginCompletion(result, v, e) }
      }
      Constants.Methods.setExtraUserProperty->{
        val extra: Map<String, String>? = call.argument(Constants.Parameter.extraProp)
        GlassfyGlue.setExtraUserProperty(extra) { v, e -> pluginCompletion(result, v, e) }
      }
      Constants.Methods.getExtraUserProperty->{
        GlassfyGlue.getExtraUserProperty() { v, e -> pluginCompletion(result, v, e) }
      }
      Constants.Methods.connectCustomSubscriber->{
        val subscriberId: String? = call.argument(Constants.Parameter.subscriberId)
        GlassfyGlue.connectCustomSubscriber(subscriberId) { v, e -> pluginCompletion(result, v, e) }
      }
      Constants.Methods.connectPaddleLicenseKey->{
        val licenseKey: String = call.argument(Constants.Parameter.licenseKey) ?: ""
        val force: Boolean = call.argument(Constants.Parameter.force) ?: false
        GlassfyGlue.connectPaddleLicenseKey(licenseKey, force) { v, e -> pluginCompletion(result, v, e) }
      }
      Constants.Methods.connectGlassfyUniversalCode->{
        val universalCode: String = call.argument(Constants.Parameter.universalCode) ?: ""
        val force: Boolean = call.argument(Constants.Parameter.force) ?: false
        GlassfyGlue.connectGlassfyUniversalCode(universalCode, force) { v, e -> pluginCompletion(result, v, e) }
      }
      Constants.Methods.setAttribution->{
        val type: Int = call.argument(Constants.Parameter.type) ?: -1
        val value: String = call.argument(Constants.Parameter.value) ?: ""
        GlassfyGlue.setAttribution(type,value) { v, e -> 
          pluginCompletion(result, v, e)
        }
      }
      Constants.Methods.setAttributions->{
        val items: List<Map<String, Any?>> = call.argument(Constants.Parameter.items) ?: listOf()
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
