package com.idfaidfvgaid

import com.facebook.react.ReactPackage
import com.facebook.react.bridge.NativeModule
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.uimanager.ViewManager

class IdfaIdfvGaidPackage : ReactPackage {
    override fun createNativeModules(reactContext: ReactApplicationContext): List<NativeModule> {
        require(reactContext.hasActiveReactInstance()) {
            "IdfaIdfvGaidPackage: ReactApplicationContext has no active React instance."
        }
        return listOf(IdfaIdfvGaidModule(reactContext))
    }

    override fun createViewManagers(reactContext: ReactApplicationContext): List<ViewManager<*, *>> =
        emptyList()
}
