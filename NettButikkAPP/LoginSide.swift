//
//  LoginSide.swift
//  NettButikkAPP
//
//  Created by Endre Jørstad Kvisgaard on 01/04/2023.
//

import SwiftUI

struct LoginSide: View {
    @State private var username = ""
    @State private var password = ""
    @State private var authenticated = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Brukernavn", text: $username)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                SecureField("Passord", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                Button(action: {
                    authenticateUser()
                }) {
                    Text("Log in")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.blue)
                        .cornerRadius(15.0)
                }
                
                NavigationLink(
                    destination: ContentView(),
                    isActive: $authenticated,
                    label: { EmptyView() }
                )
            }
            .padding()
        }
    }
    
    func authenticateUser() {
        let url = URL(string: "https://dummyjson.com/auth/login")!
        let body = ["username": username, "password": password]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if (try? JSONDecoder().decode(AuthResponse.self, from: data)) != nil {
                    DispatchQueue.main.async {
                        authenticated = true
                    }
                    
                    return
                }
            }

            print("Feil brukernavn eller passord")
        }.resume()
    }
}

struct AuthResponse: Codable {
    let token: String
}
