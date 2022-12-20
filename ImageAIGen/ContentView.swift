//
//  ContentView.swift
//  ImageAIGen
//
//  Created by NomoteteS on 20.12.2022.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var APICallerModel = APICaller()
    @State var text = ""
    @State var image: UIImage?
    var body: some View {
        NavigationView {
            VStack{
                Spacer()
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250, height: 250)
                } else {
                    Text("Type prompt to generate image!")
                }
                Spacer()
                
                TextField("Type",text: $text)
                    .padding()
            
                Button("Generate") {
                    if !text.trimmingCharacters(in: .whitespaces).isEmpty {
                        Task{
                            let result = await APICallerModel.generateImage(prompt: text)
                            if result == nil {
                            }
                            self.image = result
                        }
                        }
                    }
                }
                
            }
            .padding()
            .navigationTitle("hey")
            .onAppear{
                APICallerModel.setup()
                }
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
