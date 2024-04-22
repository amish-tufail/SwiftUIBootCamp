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
    
    init(url: String) {
        _loader = StateObject(wrappedValue: DownloadImageViewModel(url: url))
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
    DownloadImageView(url: "https://via.placeholder.com/600/92c952")
}

class DownloadImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    let urlString: String
    var cancellables = Set<AnyCancellable>()
    
    init(url: String) {
        urlString = url
        downloadImage()
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
                self?.image = returnedImage
            }
            .store(in: &cancellables)
    }
}
