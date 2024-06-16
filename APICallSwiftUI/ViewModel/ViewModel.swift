//
//  ViewModel.swift
//  APICallSwiftUI
//
//  Created by Bhushan Borse DXC on 03/05/24.
//

import Foundation

struct Course: Hashable, Codable {
    let name: String
    let image: String
}

class ViewModel: ObservableObject {
    
    @Published var courses: [Course] = []
    
    
    func fetch() {
        guard let url = URL(string: "https://iosacademy.io/api/v1/courses/index.php") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                
                let courses = try JSONDecoder().decode([Course].self, from: data)
                
                DispatchQueue.main.async {
                    self?.courses = courses
                }
                
            } catch {
                print("Error ->", error)
            }
        }
        task.resume()
    }
}
