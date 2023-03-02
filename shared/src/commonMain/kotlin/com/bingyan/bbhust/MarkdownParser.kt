package com.bingyan.bbhust

import life.xeu.markdown.AstParser
import life.xeu.markdown.Element
import life.xeu.markdown.MarkdownParser

object MarkdownAST {
    fun parse(markdown:String): Element {
        val html = MarkdownParser.parse(markdown)
        return AstParser.parse(html)
    }
    val exampleText = """
                    # Hello,*World*!
                    ## Sub**title**
                    ### 分割线 ⬇️
                    =======
                    `Code here`
                    **强调***斜体*与***着重强调***
                    **强调测试*斜Italic体*与我![img](https://upload-images.jianshu.io/upload_images/4323309-d6eeff42611fe812.png?imageMogr2/auto-orient/strip|imageView2/2/w/686/format/webp)们的*气哦还有~~删除线~~昂掉***
    """.trimIndent()


    
}