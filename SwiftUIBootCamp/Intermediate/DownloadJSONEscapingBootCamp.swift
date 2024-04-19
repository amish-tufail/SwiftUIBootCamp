//
//  DownloadJSONEscapingBootCamp.swift
//  SwiftUIBootCamp
//
//  Created by Amish on 19/04/2024.
//

import SwiftUI


struct PostModel: Identifiable, Codable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}

class DownloadJSONEscapingViewModel: ObservableObject {
    @Published var posts: [PostModel] = []
    init() {
        getPosts()
    }
    
    func getPosts() {
       
        downloadData(fromURL: URL(string: "https://jsonplaceholder.typicode.com/posts/")!) { data in
            if let data = data {
                print("DATA download Success")
                print(data)
                print(String(data: data, encoding: .utf8) as Any)
                // Decode data
                guard let decodedData = try? JSONDecoder().decode([PostModel].self, from: data) else { return }
                // Append data
                DispatchQueue.main.async { [weak self] in
                    self?.posts = decodedData
                }
            } else {
                print("No Data returned")
            }
        }
    }
    
    func downloadData(fromURL url: URL, completionHandler: @escaping (_ data: Data?) -> ()) {
        // Goes and fetched the data
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300,
                error == nil
            else {
                // Incase of failer completion will return nil
                completionHandler(nil)
                return
            }
            // Return data
            completionHandler(data)
        }.resume()
    }
}
struct DownloadJSONEscapingBootCamp: View {
    @StateObject var vm = DownloadJSONEscapingViewModel()
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .bold()
                    Text(post.body)
                }
            }
        }
    }
}

#Preview {
    DownloadJSONEscapingBootCamp()
}
