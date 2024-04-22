//
//  DownloadImageView.swift
//  SwiftUIBootCamp
//
//  Created by Amish on 22/04/2024.
//

import SwiftUI
import Combine

struct DownloadImageView: View {
    @StateObject var loader: DownloadImageViewModel
    
    init(url: String, key: String) {
        _loader = StateObject(wrappedValue: DownloadImageViewModel(url: url, imageKey: key))
    }
    var body: some View {
        ZStack {
            if loader.isLoading {
                ProgressView()
            } else if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
            }
        }
    }
}

#Preview {
    DownloadImageView(url: "https://via.placeholder.com/600/92c952", key: "1")
}

class DownloadImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    let urlString: String
    let imageKey: String
    var cancellables = Set<AnyCancellable>()
    
    // For both the cache and File manager the same code, just change managers
    let manager = PhotoModelCacheManager.shared
//    let manager = PhotoFileManager.shared
    
    init(url: String, imageKey: String) {
        urlString = url
        self.imageKey = imageKey
        getImage()
    }
    
    func downloadImage() {
        isLoading = true
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .map { (data, response) -> UIImage? in
                return UIImage(data: data)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                guard 
                    let self = self,
                    let image = returnedImage else { return }
                self.image = returnedImage
                self.manager.add(key: self.imageKey, image: image)
            }
            .store(in: &cancellables)
    }
    
    func getImage() {
        if let savedImage = manager.get(key: imageKey) {
            image = savedImage
            print("Getting saved image.")
        } else {
            downloadImage()
            print("Downloading image.")
        }
    }
}
