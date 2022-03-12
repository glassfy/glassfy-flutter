package io.glassfy.glassfy_flutter

import android.content.Context
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.glassfy.glue.GlassfyGlue

/** GlassfyFlutterPlugin */
class GlassfyFlutterPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  var ctx: Context? = null;

  private fun pluginCompletion(@NonNull result: Result, value: String?, error: String?) {
    if (error != null) {
      result.error(error,null,null)
      return
    }
    result.success(value)
  }
  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    ctx = flutterPluginBinding.applicationContext;
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

        ctx?.let {
          GlassfyGlue.initialize(it , apiKey, watcherMode) { v, e -> pluginCompletion(result, v, e) }
        } ?: run {
          result.error("invalid context",null,null)
        }
      }
      "offerings" -> {
        GlassfyGlue.offerings() { v, e -> pluginCompletion(result, v, e) }
      }
      "permissions" -> {
        GlassfyGlue.permissions() { v, e -> pluginCompletion(result, v, e) }
      }
      "skuWithIdentifier" -> {
        val identifier: String = call.argument("identifier") ?: ""
        GlassfyGlue.skuWithIdentifier(identifier) { v, e -> pluginCompletion(result, v, e) }
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
