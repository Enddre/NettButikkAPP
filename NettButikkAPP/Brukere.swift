//
//  Brukere.swift
//  NettButikkAPP
//
//  Created by Endre Jørstad Kvisgaard on 31/03/2023.
//

import SwiftUI

struct Users: Decodable {
    var users: [User]
}
struct User: Identifiable, Decodable {
    let id: Int
    let firstName: String
    let username: String
    let password: String
}



struct UserRow: View {
    var user: User
    
    var body: some View {
        HStack {
    
            VStack(alignment: .leading) {
                Text(user.firstName)
                 .font(.headline)
                 .foregroundColor(.blue)
                Text(user.username)
                    .foregroundColor(.gray)
            }
        }
    }
}


struct UserDetail: View {
    var user: User
    
    var body: some View {
        VStack {
            Text("Fornavn: \(user.firstName)")
                .font(.largeTitle)
                .padding()
            Text("Brukernavn: \(user.username)")
                .padding()
            Text("Passord: \(user.password)")
                .font(.title)
                .padding()
            
            Spacer()
            
        }
    }
}


struct Brukere: View {
    
    @State var users: [User] = []
    
    var body: some View {
        NavigationView {
            List(users) { users in
        
                NavigationLink(destination: UserDetail(user: users)) {
                    UserRow(user: users)
                }
            }
            .navigationTitle("Brukere")
        }
        .onAppear {
            
            fetchUsers()
        }
    }
    

    func fetchUsers() {

        guard let url = URL(string: "https://dummyjson.com/users") else { return }
        
      
        let request = URLRequest(url: url)
        
    
        URLSession.shared.dataTask(with: request) { data, response, error in
          
            if let error = error {
                print(error.localizedDescription)
                return
            }
            

            if let data = data {
                
                do {
                    let decodedUsers = try JSONDecoder().decode(Users.self, from: data)
          
                    DispatchQueue.main.async {
                        self.users = decodedUsers.users
                    }
                } catch {
              
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}
