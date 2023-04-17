package com.bingyan.bbhust

import android.annotation.SuppressLint
import android.app.Application
import android.content.Context
import com.bingyan.bbhust.utils.SP

//@HiltAndroidApp
class App : Application() {
    companion object {
        @SuppressLint("StaticFieldLeak")
        lateinit var CONTEXT: Context
    }

    override fun onCreate() {
        super.onCreate()
        /*        UMConfigure.setLogEnabled(true)
                UMConfigure.preInit(this, "633af38d05844627b55b58e0", null)
                MobclickAgent.setPageCollectionMode(MobclickAgent.PageMode.AUTO)
                UMConfigure.setLogEnabled(true)
                Mojito.initialize(
                    CoilImageLoader.with(this),
                    SketchImageLoadFactory(),
                    object : IMojitoConfig {
                        override fun duration(): Long = 250
                        override fun maxTransYRatio(): Float = 0.16f
                        override fun errorDrawableResId(): Int = R.drawable.image_banned
                        override fun transparentNavigationBar(): Boolean = true
                    }
                )
                */
        if (SP.get("start_up", null) != null) {
//            UMConfigure.init(
//                this,
//                "633af38d05844627b55b58e0",
//                null,
//                UMConfigure.DEVICE_TYPE_PHONE,
//                ""
//            )
        }
    }

    override fun attachBaseContext(base: Context?) {
        CONTEXT = this
        super.attachBaseContext(base)
//        MMKV.initialize(this)
    }
}