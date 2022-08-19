import Foundation

// MARK: - FileServiceProtocol
protocol FileServiceProtocol {
    func getImage(imageKey: String) -> Data?
    func saveImage(imageData: Data, imageKey: String, expireTime: Date) -> Error?
}

// MARK: - FileServiceProtocol Extension
extension FileServiceProtocol {
    func saveImage(imageData: Data, imageKey: String, expireTime: Date = Date().addingTimeInterval(10 * 60)) -> Error? {
        saveImage(imageData: imageData, imageKey: imageKey, expireTime: expireTime)
    }
}

// MARK: - FileService
class FileService {
    let fileManager: FileManager = .default
    let dictUrl = "urls.json"
    let folderName = "downloaded_images"
    
    init() {
        createCacheFolderIfNeeded()
    }
}

// MARK: - ImageFile Structure
extension FileService {
    private struct ImageFile: Codable  {
        let expireTime: String
    }
}

// MARK: - Private methods
extension FileService {
    /// Creating folder and dictionary (urls.json) path if not exist
    private func createCacheFolderIfNeeded() -> Error? {
        guard let folderUrl = getFolderPath(),
              let dictFileUrl = getDictPath(),
              !fileManager.fileExists(atPath: folderUrl.path),
              !fileManager.fileExists(atPath: dictFileUrl.path) else {
            return FileServiceErrors.cacheFolderAlreadyExist
        }
        
        do {
            // Creating a folder
            try fileManager.createDirectory(at: folderUrl, withIntermediateDirectories: true)
            print("[Log] Creating a folder...")
            // Creating urls.json file
            fileManager.createFile(atPath: dictFileUrl.path, contents: nil, attributes: nil)
            print("[Log] Creating a urls.json file...")
            
        } catch let error {
            return error
        }
        
        return nil
    }
    
    /// Getting /download_images/ folder path
    private func getFolderPath() -> URL? {
        return fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(folderName)
    }
    
    /// Getting urls.json file path
    private func getDictPath() -> URL? {
        guard let folderPath = getFolderPath() else {
            return nil
        }
        
        return folderPath.appendingPathComponent(dictUrl)
    }
    
    /// Getting image.cache file path
    private func getImagePath(key: String) -> URL? {
        guard let folderPath = getFolderPath() else {
            return nil
        }
        
        return folderPath.appendingPathComponent(key)
    }
    
    /// Getting [String: ImageFile] dictionary
    private func getDictionary() -> [String: ImageFile]? {
        guard let dictPath = getDictPath(),
              let data = try? Data(contentsOf: dictPath) else {
            return nil
        }
        
        // returns [String: ImageFile]
        let decodedData = try? JSONDecoder().decode(Dictionary<String, ImageFile>.self, from: data)
        return decodedData
    }
    
    /// Getting ImageFile structure from dictionary
    private func getValue(key: String) -> ImageFile? {
        guard let dict = getDictionary() else {
            return nil
        }
        
        return dict[key]
    }
    
    /// Adding a new value to dictionary and update urls.json
    private func addValue(key: String, value: ImageFile) {
        var dict: [String: ImageFile] = getDictionary() ?? [:]
        
        dict[key] = value
        
        // Updating urls.json
        updateDictionary(dict: dict)
    }
    
    /// Removing a value from dictionary and update urls.json
    private func removeValue(key: String) -> Error? {
        guard var dict = getDictionary() else {
            return FileServiceErrors.dictionaryNotExist
        }
        
        dict.removeValue(forKey: key)
        
        // Updating urls.json
        updateDictionary(dict: dict)
        return nil
    }
    
    /// Removing a file from disk
    private func removeFile(key: String) -> Error? {
        guard let imagePath = getImagePath(key: key),
              fileManager.fileExists(atPath: imagePath.path) else {
            return FileServiceErrors.fileNotExist
        }
        
        do {
            try fileManager.removeItem(at: imagePath)
        } catch let error {
            return error
        }
        
        return nil
    }
    
    /// Updating values of urls.json dictionary
    private func updateDictionary(dict: [String: ImageFile]) {
        guard let dictPath = getDictPath(),
              let data = try? JSONEncoder().encode(dict) else {
            fatalError()
        }
        
        try? data.write(to: dictPath)
    }
}

// MARK: - Public methods
extension FileService: FileServiceProtocol {
    
    /// Getting image file from disk
    public func getImage(imageKey: String) -> Data? {
        guard let imagePath = getImagePath(key: imageKey),
              let value = getValue(key: imageKey),
              fileManager.fileExists(atPath: imagePath.path) else {
            return nil
        }
        
        guard let expiredTime = DateFormatter.fullDateTime.date(from: value.expireTime),
              expiredTime > Date() else {
            guard removeValue(key: imageKey) == nil,
                  removeFile(key: imageKey) == nil else {
                return nil
            }
            
            return nil
        }
        
        return try? Data(contentsOf: imagePath)
    }
    
    /// Saving file to disk and adding new value to dictionary urls.json. Default expire time is 10 minutes
    public func saveImage(imageData: Data, imageKey: String, expireTime: Date = Date().addingTimeInterval(10 * 60)) -> Error? {
        guard let imagePath = getImagePath(key: imageKey) else {
            return FileServiceErrors.imagePathNotExist
        }
        
        do {
            try imageData.write(to: imagePath)
            let expireTimeString = DateFormatter.fullDateTime.string(from: expireTime)
            
            addValue(key: imageKey, value: ImageFile(expireTime: expireTimeString))
        } catch let error {
            return error
        }
        
        return nil
    }
}

// MARK: - FileServiceErrors
extension FileService {
    private enum FileServiceErrors: Error {
        case cacheFolderAlreadyExist
        case fileNotExist
        case dictionaryNotExist
        case imagePathNotExist
    }
}
