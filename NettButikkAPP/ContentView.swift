//
//  Contentview.swift
//  NettButikkAPP
//
//  Created by Endre Jørstad Kvisgaard on 20/03/2023.
//


import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
             Produkter()
                .tabItem {
                    Image(systemName: "dollarsign.circle.fill")
                    Text("Produkter")
                }
            Brukere()
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("Bruker")
                }
            Handlevogn()
               .tabItem {
                   Image(systemName: "cart.circle")
                   Text("Handlevogn")
               }
        }
    }
}

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
    }
}

