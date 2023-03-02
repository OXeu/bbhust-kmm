package com.bingyan.bbhust.utils


import com.apollographql.apollo3.ApolloClient
import com.apollographql.apollo3.api.ApolloRequest
import com.apollographql.apollo3.api.ApolloResponse
import com.apollographql.apollo3.api.Operation
import com.apollographql.apollo3.interceptor.ApolloInterceptor
import com.apollographql.apollo3.interceptor.ApolloInterceptorChain
import kotlinx.coroutines.flow.Flow

object ApolloUtils {
    private val BASE_URL = //if (SP.get("server", "true").equals("true"))
        "https://api.hust.online/bbhust2/api/graphql"
//    else "https://api.hust.online/bbhust-dev2/api/graphql"

    private val builder: ApolloClient.Builder = ApolloClient.Builder()

    init {
        builder.serverUrl(BASE_URL)
    }

    fun build(token: String?): ApolloClient {
        if (token != null) {
            builder.addInterceptor(object : ApolloInterceptor {
                override fun <D : Operation.Data> intercept(
                    request: ApolloRequest<D>,
                    chain: ApolloInterceptorChain
                ): Flow<ApolloResponse<D>> {
                    val requestBuilder = request.newBuilder()
                        .addHttpHeader("Authorization", "Bearer $token")
                    return chain.proceed(requestBuilder.build())
                }
            })
        }
        return builder.build()
    }

}