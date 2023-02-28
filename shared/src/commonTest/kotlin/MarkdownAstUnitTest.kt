import com.bingyan.bbhust.MarkdownAST
import life.xeu.markdown.AstParser
import life.xeu.markdown.MarkdownParser
import kotlin.test.Test

class MarkdownAstUnitTest {
    @Test
    fun markdownTest(){
        val md = """
            # Hello,World!
            ## Subtitle
            =======
            `Code here`
        """.trimIndent()
        val html = MarkdownParser.parse(md)
        val ast = AstParser.parse(html)
        println(html)
        println("============")
        println(ast)
    }
}