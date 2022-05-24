package io.glassfy.glue


import android.app.Activity
import io.glassfy.androidsdk.Glassfy
import io.glassfy.androidsdk.Glassfy.sku
import io.glassfy.androidsdk.GlassfyError
import io.glassfy.androidsdk.LogLevel
import io.glassfy.androidsdk.model.Sku
import io.glassfy.androidsdk.model.Store
import org.json.JSONObject

typealias GlueCallback = (String?, String?) -> Unit

interface Filter<T> {
  fun filterError(result: T, err: GlassfyError, callback: GlueCallback, processvalue: (T) -> String)
}

object GlassfyGlue {

  fun sdkVersion(callback: GlueCallback) {
    val jo = JSONObject()
    jo.put("version", Glassfy.sdkVersion)
    callback(jo.toString(), null)
  }

  fun initialize(
    ctx: android.content.Context,
    apiKey: String,
    watcherMode: Boolean,
    callback: GlueCallback
  ) {
    Glassfy.initialize(ctx, apiKey, watcherMode) { _, err ->
      callback(null, err?.toString())
    }
  }

  fun setLogLevel(logLevel:Int) {
    if (logLevel == 0)
      Glassfy.setLogLevel(LogLevel.NONE)
    else if (logLevel == 1)
      Glassfy.setLogLevel(LogLevel.ERROR)
    else if (logLevel >= 2)
      Glassfy.setLogLevel(LogLevel.DEBUG)
  }

  fun offerings(callback: GlueCallback) {
    Glassfy.offerings { offerings, err ->
      if (err != null) {
        callback(null, err.toString())
      } else if (offerings != null) {
        val offeringEncoded = offerings.encodedJson()
        callback(offeringEncoded.toString(), null)
      }
    }
  }

  fun permissions(callback: GlueCallback) {
    Glassfy.permissions { permissions, err ->
      if (err != null) {
        callback(null, err.toString())
      } else if (permissions != null) {
        val permissionsEncoded = permissions.encodedJson()
        callback(permissionsEncoded.toString(), null)
      }
    }
  }

  fun skuWithId(identifier: String, callback: GlueCallback) {
    sku(identifier) { sku, err ->
      if (err != null) {
        callback(null, err.toString())
        return@sku
      } else if (sku != null) {
        val skuEncode = sku.encodedJson()
        callback(skuEncode.toString(), null)
      }
    }
  }

  fun skuWithIdAndStore(identifier: String,store:Int, callback: GlueCallback) {
    var gyStore:Store = Store.PlayStore
    when (store) {
      Store.AppStore.value -> gyStore = Store.AppStore;
      Store.PlayStore.value -> gyStore = Store.PlayStore;
      Store.Paddle.value -> gyStore = Store.Paddle;
      else -> {
        callback(null, "invalid store")
        return
      }
    }
    sku(identifier,gyStore) { sku, err ->
      if (err != null) {
        callback(null, err.toString())
        return@sku
      } else if (sku != null) {
        val skuEncode = sku.encodedJson()
        callback(skuEncode.toString(), null)
      }
    }
  }

  fun purchaseSku(activity: Activity, skuId: String, callback: GlueCallback) {
     sku(skuId) { sku, skuerr ->
       if (skuerr != null) {
         callback(null, skuerr.toString())
         return@sku
       } else if (sku == null) {
         callback(null, "InternalError")
         return@sku
       }
       Glassfy.purchase(activity, sku, null) { transaction, err ->
         if (err != null) {
           callback(null, err.toString())
           return@purchase
         }
         callback(transaction?.encodedJson().toString(), null)
       }
     }
  }

  fun purchaseSku(activity: Activity, purchaseSku: Sku, callback: GlueCallback) {
     return purchaseSku(activity,purchaseSku.skuId,callback)
  }

  fun restorePurchases(callback: GlueCallback) {
    Glassfy.restore() { permissions, err ->
      if (err != null) {
        callback(null, err.toString())
        return@restore
      } else if (permissions == null) {
        callback(null, "InternalError")
        return@restore
      }
      val permissionsEncode = permissions.encodedJson()
      callback(permissionsEncode.toString(), null)
    }
  }

  fun setEmailUserProperty(email: String,callback: GlueCallback) {
    Glassfy.setEmailUserProperty(email) { err ->
      callback(null, err?.toString())
    }
  }

  fun setExtraUserProperty(extra:Map<String, String>?,callback: GlueCallback) {
    Glassfy.setExtraUserProperty(extra) { err ->
      callback(null, err?.toString())
    }
  }

  fun getExtraUserProperty(callback: GlueCallback) {
    Glassfy.getUserProperties { extra, err ->
      if (err != null) {
        callback(null, err.toString())
        return@getUserProperties
      } else if (extra == null) {
        callback(null, "InternalError")
        return@getUserProperties
      }
      val extraEncode = extra.encodedJson()
      callback(extraEncode.toString(), err?.toString())
    }
  }

  fun connectCustomSubscriber(subscriberId:String?,callback: GlueCallback) {
    Glassfy.connectCustomSubscriber(subscriberId){ err ->
      callback(null, err?.toString())
    }
  }

  fun connectPaddleLicenseKey(licenseKey:String,force:Boolean,callback: GlueCallback) {
    Glassfy.connectPaddleLicenseKey(licenseKey,force){ err ->
      callback(null, err?.toString())
    }
  }
}

