package com.bingyan.bbhust.utils

import com.bingyan.bbhust.App
import com.liftric.kvault.KVault

actual fun getKVault(file: String) = KVault(App.CONTEXT, file)