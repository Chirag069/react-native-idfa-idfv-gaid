package com.idfaidfvgaid

import com.facebook.react.bridge.*
import com.google.android.gms.ads.identifier.AdvertisingIdClient
import kotlinx.coroutines.*

private const val ZERO_UUID = "00000000-0000-0000-0000-000000000000"

class IdfaIdfvGaidModule(private val reactContext: ReactApplicationContext) :
    ReactContextBaseJavaModule(reactContext) {

    // Scoped to the module lifecycle to prevent coroutine leaks
    private val scope = CoroutineScope(SupervisorJob() + Dispatchers.IO)

    override fun getName(): String = "IdfaIdfvGaid"

    @ReactMethod
    fun getGAID(promise: Promise) {
        scope.launch {
            try {
                val info = AdvertisingIdClient.getAdvertisingIdInfo(reactContext)
                val id = if (info.isLimitAdTrackingEnabled) ZERO_UUID else (info.id ?: ZERO_UUID)
                promise.resolve(id)
            } catch (e: Exception) {
                promise.reject("GAID_ERROR", e.message ?: "Unknown error", e)
            }
        }
    }

    override fun invalidate() {
        super.invalidate()
        scope.cancel()
    }
}
