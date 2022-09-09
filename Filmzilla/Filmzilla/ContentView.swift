//
//  ContentView.swift
//  Filmzilla
//
//  Created by Павло on 27.08.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            FutureFilmsView()
                .tabItem{
                    Label("Films I'd like to watch", systemImage: "film")
                }
            
            
            WatchedFilmsView()
                .tabItem{
                    Label("Films I've watched", systemImage: "checkmark")
                }
        }
        .accentColor(Color.pink)
        .environment(\.colorScheme, .dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
