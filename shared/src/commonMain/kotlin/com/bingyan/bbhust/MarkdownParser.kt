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
    """.trimIndent()


    
}