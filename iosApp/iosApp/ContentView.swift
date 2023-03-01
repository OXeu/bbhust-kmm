import SwiftUI
import shared

struct ContentView: View {
	let greet = Greeting().greet()
    let ast = MarkdownAST().parse(markdown: MarkdownAST().exampleText).makeLines()

	var body: some View {
        Node(ast: ast)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}


struct Node: View{
    var ast:[[MarkdownNode]]
    var body: some View {
        VStack {
            ForEach(ast,id: \.hashValue) { line in
                if line.count == 1 {
                    let child = line[0]
                    if(child is MarkdownElement){
                        let node = child as! MarkdownElement
                        switch(node.name){
                        case "h1":
                            Text(line.map({node in Inline(ast: node)}).zip()).font(.largeTitle)
                        case "hr":
                            Divider()
                        default:
                            Text(line.map({node in Inline(ast: node)}).zip())
                        }
                    }
                }else{
                    Text(line.map({node in Inline(ast: node)}).zip())
                }
            }
        }
    }
}

func Inline(ast:MarkdownNode) -> AttributedString {
    if(ast is MarkdownElement){
        let ast = ast as! MarkdownElement
        let attrs = (ast.children as NSArray as! [MarkdownNode]).map({ child in
            if(child is MarkdownElement){
                let node = child as! MarkdownElement
                switch(node.name){
                case "code":
                    var inline =  Inline(ast: node)
                    inline.backgroundColor = .cyan
                    return inline
                case "pre":
                    var inline =  Inline(ast: node)
                    inline.backgroundColor = .blue
                    return inline
                case "strong":
                    var inline =  Inline(ast: node)
                    inline.inlinePresentationIntent = .stronglyEmphasized
                    return inline
                case "em":
                    var inline =  Inline(ast: node)
                    inline.inlinePresentationIntent = .emphasized
                    return inline
                default:
                    return Inline(ast: node)
                }
            }else{
                return AttributedString("\(child)")
            }
        }).zip()
        return attrs
    }else{
        return AttributedString("\(ast)")
    }
}

extension [AttributedString] {
    func zip() -> AttributedString {
        var result = AttributedString()
        self.forEach({ it in
            result.append(it)
        })
        return result
    }
}

extension MarkdownElement {
    func makeLines() -> [[MarkdownNode]]{
        var lines :[[MarkdownNode]] = []
        var currentLine:[MarkdownNode] = []
        self.children.forEach({ child in
            if(child is MarkdownElement){
                let node = child as! MarkdownElement
                switch(node.name){
                case "h1","h2","h3","h4","h5","h6","pre","blockquote","table","hr":
                    if !currentLine.isEmpty{
                        lines.append(currentLine)
                        currentLine = []
                    }
                    lines.append([node])
                case "br":
                    if !currentLine.isEmpty{
                        lines.append(currentLine)
                        currentLine = []
                    }
                default:
                    currentLine.append(node)
                }
            }
        })
        if !currentLine.isEmpty{
            lines.append(currentLine)
            currentLine = []
        }
        return lines
    }
}
