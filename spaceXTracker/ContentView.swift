//
//  ContentView.swift
//  spaceXTracker
//
//  Created by Mustafa Yanar on 2.10.2023.
//

import SwiftUI

struct ContentView: View {
    @State var patchString: URL?
    @State var name: String = "Name not available"
    var model : SpaceXLaunchInfo?
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                if let imageURL = patchString {
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                } else {
                    Text("Image not available")
                }
                Text(name)
            }
            .padding()
            .foregroundColor(.white)
            .onAppear {
                Service.shared.request { model in
                    let urlString = model.links.patch.small
                    patchString = URL(string: urlString)
                    name = model.name
                }
            }
        }
    }
    
    func serviceHandler(response: SpaceXLaunchInfo) {
        print(response.name)
        print(response.links.patch)
        print(response.details ?? "")
        print(response.date_utc)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
