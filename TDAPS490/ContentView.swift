//
//  ContentView.swift
//  ARImageTracking
//
//  Created by Qi on 8/1/21.
//

import ARKit
import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        return ARViewContainer().edgesIgnoringSafeArea(.all)
        
        // Create three bottom tabs
        //TabView{
           // Text("Tab1").tabItem {
          //      Text("Manu")
         //   }

          //  ARViewContainer().edgesIgnoringSafeArea(.all).tabItem {
          //      Image(systemName: "viewfinder")
         //       Text("Scan")
         //   }

          //  SettingsView().tabItem {
           //     Image(systemName: "gear")
          //      Text("Settings")
           // }
        //}
    }
}

