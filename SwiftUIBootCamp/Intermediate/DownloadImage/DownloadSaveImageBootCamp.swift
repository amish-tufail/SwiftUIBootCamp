//
//  DownloadSaveImageBootCamp.swift
//  SwiftUIBootCamp
//
//  Created by Amish on 22/04/2024.
//

import SwiftUI
import Combine

struct DownloadSaveImageBootCamp: View {
    @StateObject var vm = DownloadSaveImageViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.dataArray) { model in
                    downloadImageRow(model: model)
                }
            }
            .navigationTitle("Downloading Images 😞")
        }
    }
    
    func downloadImageRow(model: PhotoModel) -> some View {
        return HStack {
            DownloadImageView(url: model.url)
                .frame(width: 75.0, height: 75.0, alignment: .center)
            VStack(alignment: .leading) {
                Text(model.title)
                    .font(.headline)
                Text(model.url)
                    .foregroundStyle(.gray)
                    .italic()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    DownloadSaveImageBootCamp()
}

// Model

struct PhotoModel: Identifiable, Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}

// ViewModel

class DownloadSaveImageViewModel: ObservableObject {
    @Published var dataArray: [PhotoModel] = []
    let dataService = PhotoModelDataService.instance
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$photoModels
            .sink { [weak self] photoModels in
                self?.dataArray = photoModels
            }
            .store(in: &cancellables)
    }
}

// Utlilities

class PhotoModelDataService {
    static let instance = PhotoModelDataService()
    @Published var photoModels: [PhotoModel] = []
    var cancellables = Set<AnyCancellable>()
    private init() {
        downloadData()
    }
    
    func downloadData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error downloading: \(error)")
                }
            } receiveValue: { [weak self] (returnedPhotoModel) in
                self?.photoModels = returnedPhotoModel
            }
            .store(in: &cancellables)

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






