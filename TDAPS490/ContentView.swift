//
//  ContentView.swift
//  TDaps490
//
//  Created by Sam Wang on 2021-01-15.
//

import SwiftUI

struct ContentView : View {
    var body: some View {
        // return ARViewContainer().edgesIgnoringSafeArea(.all)
        
        // Create three bottom tabs
        TabView{
            Text("Tab1").tabItem {
                Text("Manu")
            }

            ARViewContainer().edgesIgnoringSafeArea(.all).tabItem {
                Image(systemName: "viewfinder")
                Text("Scan")
            }

            SettingsView().tabItem {
                Image(systemName: "gearshape")
                Text("Settings")
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
