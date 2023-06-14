package io.glassfy.glassfy_flutter

import android.net.Uri
import android.util.Log
import io.glassfy.androidsdk.GlassfyError
import io.glassfy.androidsdk.model.Sku
import io.glassfy.androidsdk.model.Transaction
import io.glassfy.glue.encodedJson
import io.glassfy.paywall.PaywallFragment
import org.json.JSONObject

class FlutterPaywallListener(private val handler: (String, JSONObject) -> Unit) {
    val onClose: (Transaction?, GlassfyError?) -> Unit = { transaction, error -> 
        Log.d("FlutterPaywallListener", "onClose")
        val payload = JSONObject().apply {
            put("transaction", transaction?.encodedJson())
            put("error", error?.toString())
        }
        handler("onClose", payload)
    }

    val onLink: (Uri) -> Unit = { url ->
        Log.d("FlutterPaywallListener", "onLink $url")
        val payload = JSONObject().apply {
            put("url", url.toString())
        }
        handler("onLink", payload)
    }

    val onRestore: () -> Unit = {
        Log.d("FlutterPaywallListener", "onRestore")
        val payload = JSONObject().apply {
            // ...
        }
        handler("onRestore", payload)
    }

    val onPurchase: (Sku) -> Unit = { sku ->
        Log.d("FlutterPaywallListener", "onPurchase")
        val payload = JSONObject().apply {
            put("sku", sku.encodedJson())
        }
        handler("onPurchase", payload)
    }
}