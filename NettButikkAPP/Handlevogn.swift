//
//  Handlevogn.swift
//  NettButikkAPP
//
//  Created by Endre Jørstad Kvisgaard on 31/03/2023.
//

import SwiftUI

struct Handlevogn: View {
    @State private var cartDetails: CartDetails?
    
    var body: some View {
        VStack {
            if let cart = cartDetails?.carts.first {
                Text("Handlevogn")
                    .font(.largeTitle)
                    .padding()
                
                List(cart.products) { product in
                    HStack {
                        Text(product.title)
                        Spacer()
                        Text("$\(product.price, specifier: "%.2f")")
                            .foregroundColor(.green)
                    }
                }
            } else {
                Text("Laster opp...")
            }
        }
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        guard let url = URL(string: "https://dummyjson.com/carts") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
                
                if let decodedResponse = try? JSONDecoder().decode(CartDetails.self, from: data) {
                    DispatchQueue.main.async {
                        self.cartDetails = decodedResponse
                    }
                    return
                }
            }
            
            if let response = response {
                print("Response: \(response)")
            } else {
                print("Response: nil")
            }
            
            if let error = error {
                print("Error: \(error)")
            } else {
                print("Error: nil")
            }
        }.resume()
    }
    
    
    struct CartDetails: Codable {
        var carts: [Cart]
        var total: Int
        var skip: Int
        var limit: Int
    }

    struct Cart: Codable {
        var id: Int
        var products: [Product]
        var total: Double
        var discountedTotal: Double
        var userId: Int
        var totalProducts: Int
        var totalQuantity: Int
    }

    struct Product: Codable, Identifiable {
        var id: Int
        var title: String
        var price: Double
        var quantity: Int
        var total: Double
        var discountPercentage: Double
        var discountedPrice: Double
    }
}


