//
//  Data.swift
//  SwiftUI  News API
//
//  Created by elhajjaji on 10/19/20.
//

import Foundation
import SwiftUI
import SwiftyJSON
import WebKit


struct dataType : Identifiable {
    
    var id : String
    var title : String
    var desc : String
    var url : String
    var image : String
    
}

class getData : ObservableObject {
    
    @Published var datas = [dataType]()
    
    init() {
        
        let source = "https://newsapi.org/v2/top-headlines?country=us&apiKey=c95d489f480545159507f4b4df444c7b"
        let url = URL(string: source)!
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url){(data, _,err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            let  json = try! JSON(data: data!)
            for i in json["articles"]{
                let title = i.1["title"].stringValue
                let description = i.1["description"].stringValue
                let url = i.1["url"].stringValue
                let urlToImage = i.1["urlToImage"].stringValue
                let id = i.1["publishedAt"].stringValue

                DispatchQueue.main.async {
                    self.datas.append(dataType(id: id, title: title, desc: description, url: url, image: urlToImage))

                }
                
            }
        }.resume()
    }
}


struct WebView: UIViewRepresentable {
    var url : String
    
  func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
  let view = WKWebView()
    view.load(URLRequest(url: URL(string: url)!))
    return view
  }

  func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>){
        
    }
  }

