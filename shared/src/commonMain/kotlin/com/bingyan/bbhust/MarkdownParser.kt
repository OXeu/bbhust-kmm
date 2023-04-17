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

object StringUtils {
    /**
     * 从正文中提取图片
     * @return List<Pair<图片名称,图片链接>>
     */
    fun pickImages(it: String) = Regex("!\\[([\\W\\w]*?)]\\((\\S+?)\\)")
        .findAll(it).map {
            //Pair(it.groupValues[1], it.groupValues[2])
            it.groupValues[2]
        }.take(9).toSet().toList()

    fun removeImages(it: String) =
        it.replace(Regex("!\\[]\\((\\S+?)\\)"), "")
            .replace(Regex("!\\[([\\W\\w]*?)]\\((\\S+?)\\)"), "")
            .trim()

}