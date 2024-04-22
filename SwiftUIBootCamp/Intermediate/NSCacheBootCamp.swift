//
//  NSCacheBootCamp.swift
//  SwiftUIBootCamp
//
//  Created by Amish on 22/04/2024.
//

import SwiftUI

class CacheManager {
    static let instance = CacheManager()
    
    private init() {} // Makes sure that we dont initialize this class anywhere else
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100 // Limit memory usage
        cache.totalCostLimit = 1024 * 1024 * 100 // 100mb, total amount of data it can hold, when exceed removes the all exisiting and start taking new
        return cache
    }()
    
    func add(image: UIImage, name: String) -> String {
        imageCache.setObject(image, forKey: name as NSString)
        return "Image added to cache."
    }
    
    func delete(name: String)  -> String {
        imageCache.removeObject(forKey: name as NSString)
        return "Cache Image deleted."
    }
    
    func get(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
}

class NSCacheBootCampViewModel: ObservableObject {
    @Published var startingImage: UIImage? = nil
    @Published var cachedImage: UIImage? = nil
    @Published var infoMessage: String = ""
    let imageName: String = "testImage"
    let manager = CacheManager.instance
    
    init() {
        getImageFromAssets()
    }
    
    func getImageFromAssets() {
        startingImage = UIImage(named: imageName)
    }
    
    func saveToCache(){
        guard let image = startingImage else { return }
        infoMessage = manager.add(image: image, name: imageName)
    }
    
    func removeFromCache(){
        infoMessage = manager.delete(name: imageName)
    }
    
    func getFromCache() {
        if let returnedImage = manager.get(name: imageName) {
            cachedImage = returnedImage
            infoMessage = "Got image from cache."
        } else {
            infoMessage = "Image not found in cache."
        }
    }
}

struct NSCacheBootCamp: View {
    @StateObject var vm = NSCacheBootCampViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if let image = vm.startingImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200.0, height: 200.0)
                        .clipped()
                        .clipShape(.rect(cornerRadius: 10.0))
                }
                Text(vm.infoMessage)
                    .font(.headline)
                    .foregroundStyle(.red)
                    .padding(20.0)
                HStack {
                    Button {
                        vm.saveToCache()
                    } label: {
                        Text("Save")
                    }
                    .buttonStyle(BorderedButtonStyle())
                    Button {
                        vm.removeFromCache()
                    } label: {
                        Text("Delete")
                    }
                    .buttonStyle(BorderedButtonStyle())
                    Button {
                        vm.getFromCache()
                    } label: {
                        Text("Get")
                    }
                    .buttonStyle(BorderedButtonStyle())
                }
                if let image = vm.cachedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200.0, height: 200.0)
                        .clipped()
                        .clipShape(.rect(cornerRadius: 10.0))
                }
                Spacer()
            }
            .navigationTitle("NSCache")
        }
    }
}

#Preview {
    NSCacheBootCamp()
}
