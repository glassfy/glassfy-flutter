package io.glassfy.glassfy_flutter.utils

internal object Constants {

    object Methods {
        const val GET_PLATFORM_VERSION = "getPlatformVersion"
        const val SDK_VERSION = "sdkVersion"
        const val INITIALIZE = "initialize"
        const val SET_LOG_LEVEL = "setLogLevel"
        const val OFFERINGS = "offerings"
        const val PURCHASE_HISTORY = "purchaseHistory"
        const val PERMISSIONS = "permissions"
        const val SKU_WITH_ID = "skuWithId"
        const val SKU_WITH_ID_AND_STORE = "skuWithIdAndStore"
        const val PURCHASE_SKU = "purchaseSku"
        const val RESTORE_PURCHASES = "restorePurchases"
        const val SET_DEVICE_TOKEN = "setDeviceToken"
        const val SET_EMAIL_USER_PROPERTY = "setEmailUserProperty"
        const val SET_EXTRA_USER_PROPERTY = "setExtraUserProperty"
        const val GET_EXTRA_USER_PROPERTY = "getExtraUserProperty"
        const val CONNECT_CUSTOM_SUBSCRIBER = "connectCustomSubscriber"
        const val CONNECT_PADDLE_LICENSE_KEY = "connectPaddleLicenseKey"
        const val CONNECT_GLASSFY_UNIVERSAL_CODE = "connectGlassfyUniversalCode"
        const val SET_ATTRIBUTION = "setAttribution"
        const val SET_ATTRIBUTIONS = "setAttributions"
    }

    object Parameter {
        const val API_KEY = "apiKey"
        const val WATCHER_MODE = "watcherMode"
        const val VERSION = "version"
        const val LOG_LEVEL = "logLevel"
        const val IDENTIFIER = "identifier"
        const val STORE = "store"
        const val SKU = "sku"
        const val SKU_TO_UPGRADE = "skuToUpgrade"
        const val SKU_ID = "skuId"
        const val PRORATION_MODE = "prorationMode"
        const val EMAIL = "email"
        const val EXTRA_PROP = "extraProp"
        const val SUBSCRIBER_ID = "subscriberId"
        const val LICENSE_KEY = "licenseKey"
        const val FORCE = "force"
        const val UNIVERSAL_CODE = "universalCode"
        const val TYPE = "type"
        const val VALUE = "value"
        const val ITEMS = "items"
    }

    object Environment {
        const val SITE_ID = "siteId"
        const val API_KEY = "apiKey"
        const val REGION = "region"
        const val ENABLE_IN_APP = "enableInApp"
    }
}