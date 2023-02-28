package com.bingyan.bbhust

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform