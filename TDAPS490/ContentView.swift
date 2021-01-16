//
//  ContentView.swift
//  TDaps490
//
//  Created by Sam Wang on 2021-01-15.
//

import SwiftUI
import RealityKit

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

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
         
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
