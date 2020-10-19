//
//  ContentView.swift
//  SwiftUI  News API
//
//  Created by elhajjaji on 10/19/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    
    @ObservedObject var list = getData()
    
    var body: some View {
        
        NavigationView{
            List(list.datas){i in
                
                NavigationLink(
                    destination: WebView(url: i.url)
                        .navigationTitle("")){
                    HStack(spacing:15){
                        VStack(alignment: .leading, spacing: 10){
                            Text(i.title).fontWeight(.heavy)
                            Text(i.desc).lineLimit(2)
                        }
                        
                        if i.image != "" {
                            WebImage(url: URL(string: i.image)!,options: .highPriority,context: nil)
                                .resizable()
                                .frame(width:110, height:135)
                                .cornerRadius(20)
                        }
                        }.padding(.vertical,15)
                }
                    
            }.navigationTitle("Headlines")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
