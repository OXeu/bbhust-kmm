import SwiftUI
import shared

struct ContentView: View {
	let greet = Greeting().greet()
    let ast = MarkdownAST().parse(markdown: MarkdownAST().exampleText)

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
    var ast:MarkdownElement
    var body: some View {
                ForEach(ast.children as NSArray as! [MarkdownNode], id: \MarkdownNode.hash){ child in
                    VStack{
                        if(child is MarkdownElement){
                            let node = child as! MarkdownElement
                            switch(node.name){
                            case "h1":
                                Node(ast:node).font(.title)
                            case "h2":
                                Node(ast:node).font(.title2)
                            case "code":
                                Node(ast:node).font(.body).foregroundColor(.blue)
                            case "hr":
                                Divider().frame(width: 100,height: 10)
                            case "strong":
                                Node(ast:node).fontWeight(.bold)
                            case "em":
                                Node(ast:node).italic().foregroundColor(.red)
                            default:
                                Node(ast:node).font(.body)
                            }
                        }else{
                            Text(AttributedString("\(child)"))
                        }
                    }
                }
    }
}

/**
 em{ AAA } strong{ BB em{ CC } }
 
 */
func test(){
    let strong = AttributedString("Hello,World")
    AttributedSubstring()
}
