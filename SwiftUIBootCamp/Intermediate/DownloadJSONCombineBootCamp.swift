//
//  DownloadJSONCombine.swift
//  SwiftUIBootCamp
//
//  Created by Amish on 19/04/2024.
//

import SwiftUI
import Combine

class DownloadJSONCombineViewModel: ObservableObject {
    @Published var posts: [PostModel] = []
    var cancellables = Set<AnyCancellable>() // we store our publisher here
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/") else { return }
        
        // 1. Sign up for monthly subscription for package to be delivered
        // 2. Company would make the package behind the scene
        // 3. recieve the package at your front door
        // 4. make sure the box isn't damaged
        // 5. open and make sure the item is correct
        // 6. use the item!!!
        // 7. cancellable at any time!!
        
        // 1. create the publisher
        // 2. subscribe the publisher on background thread
        // 3. recieve on main thread
        // 4. tryMap (check that the data is good)
        // 5. decode (decode data into Postmodels)
        // 6. sink (put the item into our app)
        // 7. Store (cancel subscription if needed)
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background)) // Don't need here, as .dataTaskPublisher(for: url) goes into background
            .receive(on: DispatchQueue.main) // Go to main thread when receieved
//            .tryMap { (data, response) -> Data? in // Map it to type as here is Data and deal with an error if any
//                guard
//                    let response = response as? HTTPURLResponse,
//                    response.statusCode >= 200 && response.statusCode < 300 else {
//                    throw URLError(.badServerResponse)
//                }
//                return data
//            }
            .tryMap(handleOutput) // Handy function of doing the above thing
            .decode(type: [PostModel].self, decoder: JSONDecoder()) // Decode it
            .sink { (completion) in // with completion you can deal with success and failure as seen in switch statement
                print("COMPLETION: \(completion)")
//                switch completion {
//                case .finished:
//                    print("COMPLETION: \(completion)")
//                case .failure(let error):
//                    print("ERROR: \(error)")
//                }
            } receiveValue: { [weak self] (returnedResult) in // Here is the main part of sink, get data and store
                self?.posts = returnedResult
            }
            // If ever we dont care about the error, we just need result, we can replace sink with the sink below and add another modifier
        // What it does is replaces error with something like here we replace it with empty array, and if there is an error, we replace it and pass into recieveValue and we will have [] as returnedResult, but in earlier case we deal with error when error occurs then we go into completion and deal with it and dont go to recieveValue
//            .replaceError(with: [])
//            .sink(receiveValue: { [weak self] (returnedResult) in
//                self?.posts = returnedResult
//            })
            .store(in: &cancellables) // To cancel any time, as .dataTaskPublisher(for: url) will publish changes every few seconds ( here only one time but in many cases api might send data every second) so, maybe after certain recieves we want to cancel it.
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}

struct DownloadJSONCombineBootCamp: View {
    @StateObject var vm = DownloadJSONCombineViewModel()
    
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
    DownloadJSONCombineBootCamp()
}
