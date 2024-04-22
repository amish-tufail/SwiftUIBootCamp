//
//  SaveFileManager.swift
//  SwiftUIBootCamp
//
//  Created by Amish on 20/04/2024.
//

import SwiftUI

class LocalFileManager {
    static let shared = LocalFileManager()
    let folderName = "MY_APP_Images"
    init() {
        createFolderIfNeeded()
    }
    
    func createFolderIfNeeded() {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName) // Folder Name
                .path
        else {
            return
        }
        
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                print("Success creating Folder")
            } catch let error {
                print("Error creating folder: \(error)")
            }
        }
    }
    
    func deleteFolder() {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName) // Folder Name
                .path
        else {
            return
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            print("Succesfully deleted folder")
        } catch let error {
            print("Error deleteting folder: \(error)")
        }
    }
    
    
    func saveImage(image: UIImage, name: String) -> String {
        guard let data = image.jpegData(compressionQuality: 1.0) else {
            print("Error")
            return "Error getting data"
        }
////        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        let directoryTwo = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
//        //[file:///Users/mac/Library/Developer/CoreSimulator/Devices/66742D5D-F595-47AB-BD8B-B41A02A3984D/data/Containers/Data/Application/BA1FA32D-866B-4234-83B2-7517EC7569C3/Library/Caches/]
////        let directoryThree = FileManager.default.temporaryDirectory
//        
////        print(directory)
//        print(directoryTwo)
////        print(directoryThree)
//        
//        let path = directoryTwo?.appendingPathComponent("\(name).jpeg")
//        print(path)
//        //file:///Users/mac/Library/Developer/CoreSimulator/Devices/66742D5D-F595-47AB-BD8B-B41A02A3984D/data/Containers/Data/Application/BA1FA32D-866B-4234-83B2-7517EC7569C3/Library/Caches/testImage.jpeg
        
//        do {
//            try data.write(to: path)
//            print("Success")
//        } catch {
//            print("Failed")
//        }
//        guard
//            let path = FileManager
//                .default
//                .urls(for: .cachesDirectory, in: .userDomainMask)
//                .first?
//            .appendingPathComponent("\(name).jpeg") else {
//                print("Error getting path.")
//                return
//            }
        guard let path = getPathfForImage(name: name) else {
            return "Error getting path"
        }
        do {
            try data.write(to: path)
            print("Success")
            print(path)
            return "Success saving!"
        } catch let error {
            print("Failed: \(error)")
            return "Error saving!"
        }
    }
    
    func getImage(name: String) -> UIImage? {
        guard
            let path = getPathfForImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path) else {
            print("Fail to get path to get image")
            return nil
        }
        return UIImage(contentsOfFile: path)
    }
    
    func deleteImage(name: String) -> String {
        guard
            let path = getPathfForImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path) else {
            print("Fail to get path to delete")
            return "Error getting path!"
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            print("Sucess in deletion")
            return "Successfully deleted!"
        } catch let error {
            print("Error: \(error)")
            return "Failure in deleting"
        }
    }
    
    func getPathfForImage(name: String) -> URL? {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
            .appendingPathComponent("\(name).jpeg") else {
                print("Error getting path.")
                return nil
            }
        return path
    }
    
    func getPathfForImageWithFolder(name: String) -> URL? {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
            .appendingPathComponent("\(name).jpeg") else {
                print("Error getting path.")
                return nil
            }
        return path
    }
}

class SaveFileManagerViewModel: ObservableObject {
    @Published var infoMessage = ""
    @Published var image: UIImage? = nil
    let imageName: String = "testImage"
    
    let manager = LocalFileManager.shared
    init() {
        getImageFromAssetsFolder()
//        getImageFromLocalManager()
    }
    
    func getImageFromAssetsFolder() {
        image = UIImage(named: imageName)
    }
    
    func saveImage() {
        guard let image = image else {
            print("Can't get image to save")
            return
        }
        infoMessage = manager.saveImage(image: image, name: imageName)
    }
    
    func getImageFromLocalManager() {
        image = manager.getImage(name: imageName)
    }
    
    func deleteImage() {
        infoMessage = manager.deleteImage(name: imageName)
        
        manager.deleteFolder()
    }
}


struct SaveFileManager: View {
    @StateObject var vm = SaveFileManagerViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200.0, height: 200.0)
                        .clipShape(.rect(cornerRadius: 10.0, style: .continuous))
                }
                
                HStack {
                    Button {
                        vm.saveImage()
                    } label: {
                        Text("Save to FM")
                            .bold()
                            .font(.title3)
                    }
                    .buttonStyle(BorderedButtonStyle())
                    .padding(.top)
                    Button {
                        vm.deleteImage()
                    } label: {
                        Text("Delete from FM")
                            .bold()
                            .font(.title3)
                    }
                    .foregroundStyle(.red)
                    .buttonStyle(BorderedButtonStyle())
                    .padding(.top)
                }
                Text(vm.infoMessage)
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.cyan)
                Spacer()
            }
            .navigationTitle("File Manager")
        }
    }
}

#Preview {
    SaveFileManager()
}
