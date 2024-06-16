//
//  CoursesListView.swift
//  APICallSwiftUI
//
//  Created by Bhushan Borse DXC on 03/05/24.
//

import SwiftUI

struct URLImage: View {
    
    let urlString: String
    @State var data: Data?
    
    var body: some View {
        if let data = data, let uiimage = UIImage(data: data) {
            ImageSubView(uiimage: uiimage)
        } else {
            Image(systemName: "photo.on.rectangle.angled")
                .resizable()
                .cornerRadius(10.0)
                .padding(.trailing)
                .foregroundStyle(.gray)
                .frame(width: 110, height: 70)
                .aspectRatio(contentMode: .fit)
                .shadow(color: .gray, radius: 20, x: 0, y: 2)
                .onAppear{
                    fetchData()
                }
        }
    }
    
    private func fetchData() {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            self.data = data
        }
        task.resume()
    }
}

struct CoursesListView: View {
    
    @StateObject var viewModel = ViewModel()
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.courses, id: \.self) { course in
                    HStack {
                        URLImage(urlString: course.image)
                        Text(course.name)
                            .bold()
                            .font(.system(size: 16))
                            .multilineTextAlignment(.leading)
                    }
                    .padding(2)
                }
            }
            .navigationTitle("Courses")
            .onAppear(perform: {
                viewModel.fetch()
            })
        }
    }
}

#Preview {
    CoursesListView()
}

struct ImageSubView: View {
    var uiimage: UIImage
    
    var body: some View {
        Image(uiImage: uiimage)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 110, height: 70)
            .cornerRadius(10.0)
            .shadow(color: .gray, radius: 20, x: 0, y: 2)
            .padding(.trailing)
    }
}
