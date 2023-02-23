//
//  ContentView.swift
//  AR Tester
//
//  Created by 箕作勇輝 on 2/21/23.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}
//
struct ARViewContainer: UIViewRepresentable {
    //Viewがレンダリングされる前に、Viewが依存するデータや状態を提供するために、コンテキスト(Context)が使用されます
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap)))
            //pass the arView to coordinator so that we can intaractive with arview
            //contex.coordinatorは　Coordinatorプロトコルを利用するためのプロパティです。
        context.coordinator.view = arView
            //What is delegate and protocol? ->https://www.youtube.com/watch?v=ELRH8vkOlNs
            //ARsessionオブジェクトはARKitが追跡するために使用するデバイスの位置や方向などの情報を提供する。下のコードはARsessionの
            //delegateをcoordinatorに指定している
        arView.session.delegate = context.coordinator
        
        //add anchor and models
        let anchor = AnchorEntity(plane: .horizontal)
        let box = ModelEntity(mesh: MeshResource.generateBox(size: 0.3), materials: [SimpleMaterial(color: .red, isMetallic: true)])
        
        anchor.addChild(box)
        arView.scene.anchors.append(anchor)
        
        return arView
        
    }
    //create cordinator  makeCoordinator()はswiftはCoordinatorを作るためのテンプレメソッド
    //CoordinatorはSwiftUIとRealityKitとのデータを受け渡しする
    func makeCoordinator() -> Coordinator {
        Coordinator()
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
