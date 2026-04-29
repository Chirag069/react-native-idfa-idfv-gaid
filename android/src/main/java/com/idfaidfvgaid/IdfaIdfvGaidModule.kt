package com.idfaidfvgaid

import com.facebook.react.bridge.*
import com.google.android.gms.ads.identifier.AdvertisingIdClient
import kotlinx.coroutines.*

class IdfaIdfvGaidModule(private val reactContext: ReactApplicationContext) :
    ReactContextBaseJavaModule(reactContext) {

    override fun getName(): String = "IdfaIdfvGaid"

    @ReactMethod
    fun getGAID(promise: Promise) {
        CoroutineScope(Dispatchers.IO).launch {
            try {
                val info = AdvertisingIdClient.getAdvertisingIdInfo(reactContext)
                if (info.isLimitAdTrackingEnabled) {
                    promise.resolve("00000000-0000-0000-0000-000000000000")
                } else {
                    promise.resolve(info.id)
                }
            } catch (e: Exception) {
                promise.reject("GAID_ERROR", e.message, e)
            }
        }
    }
}
