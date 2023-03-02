import SwiftUI
import shared

struct MarkdownView: View {
	let greet = Greeting().greet()
    let ast = MarkdownAST().parse(markdown: MarkdownAST().exampleText).makeLines()

	var body: some View {
        Node(ast: ast)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		MarkdownView()
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
                            Text(InlineNode(child: node))
                        }
                    }
                }else{
                    Text(line.map({node in InlineNode(child: node)}).zip())
                }
            }
        }
    }
}

func Inline(ast:MarkdownNode) -> AttributedString {
    if(ast is MarkdownElement){
        let ast = ast as! MarkdownElement
        let attrs = (ast.children as NSArray as! [MarkdownNode]).map({ child in
            InlineNode(child: child)
        }).zip()
        return attrs
    }else{
        return AttributedString("\(ast)")
    }
}

func InlineNode(child:MarkdownNode) -> AttributedString{
    if(child is MarkdownElement){
        let node = child as! MarkdownElement
        switch(node.name){
        case "code":
            var inline =  Inline(ast: node)
            inline.foregroundColor = .black
            inline.backgroundColor = UIColor(red: 1, green: 0.8, blue: 0.8, alpha: 1)
            return inline
        case "pre":
            var inline =  Inline(ast: node)
            inline.backgroundColor = .blue
            return inline
        case "strong":
            var inline =  Inline(ast: node)
            inline.inlinePresentationIntent = .stronglyEmphasized
            return inline
        case "img":
            var inline =  Inline(ast: node)
            let src = node.attrs["src"]
            if src != nil{
                print("[image](\(String(describing: src!))")
            }
            return inline
        case "em":
            var inline =  Inline(ast: node)
            inline.underlineStyle = .single
            return inline
        case "del":
            var inline =  Inline(ast: node)
            inline.swiftUI.strikethroughStyle = .single
            return inline
        default:
            return Inline(ast: node)
        }
    }else{
        return AttributedString("\(child)")
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
        
        print(self)
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
            }else{
                currentLine.append(child as! MarkdownNode)
            }
        })
        if !currentLine.isEmpty{
            lines.append(currentLine)
            currentLine = []
        }
        return lines
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
