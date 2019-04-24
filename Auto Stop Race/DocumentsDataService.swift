//
//  DocumentsDataService.swift
//  Auto Stop Race
//
//  Created by RI on 15/04/2019.
//  Copyright © 2019 Torianin. All rights reserved.
//
//  Part of the code comes from:
//  https://forum.realm.io/t/swift-4-adding-updating-deleting-images-inside-realm-and-in-documents-directory/2280
//
import UIKit

protocol DocumentsDataServiceType {
    func getImage(with fileName: String) -> UIImage?
    func removeImageFromDocuments(with fileName: String)
    func removeImageFolderInDocuments()
}

final class DocumentsDataService: BaseService, DocumentsDataServiceType {

    func getImage(with fileName: String) -> UIImage? {
        let fileManager = FileManager.default
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths.object(at: 0) as! NSString
        let path = documentsDirectory.appendingPathComponent("ImagesFolder") as NSString
        let imagePath = path.appendingPathComponent(fileName)

        if fileManager.fileExists(atPath: imagePath) {
            return UIImage(contentsOfFile: imagePath)
        } else {
            print("Could not get image from documents")
            return nil
        }
    }

    func saveImageToDirectory(imageData: Data, fileName: String, folderName: String) {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths.object(at: 0) as! NSString
        let path = documentsDirectory.appendingPathComponent(folderName) as NSString
        if !FileManager.default.fileExists(atPath: path as String) {
            do {
                try FileManager.default.createDirectory(atPath: path as String, withIntermediateDirectories: true, attributes: nil)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        let imagePath = path.appendingPathComponent(fileName)
        if !FileManager.default.fileExists(atPath: imagePath as String) {
            try? imageData.write(to: URL(fileURLWithPath: imagePath))
        } else if FileManager.default.fileExists(atPath: imagePath as String) {
            try? imageData.write(to: URL(fileURLWithPath: imagePath))
        }
    }

    func removeImageFromDocuments(with fileName: String) {
        let fileManager = FileManager.default
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths.object(at: 0) as! NSString
        let path = documentsDirectory.appendingPathComponent("ImagesFolder") as NSString
        let imagePath = path.appendingPathComponent(fileName)
        do {
            try fileManager.removeItem(atPath: imagePath)
        } catch let error as NSError {
            print("Could not clear documents folder: \(error.debugDescription)")
        }
    }

    func removeImageFolderInDocuments() {
        let fileManager = FileManager.default
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths.object(at: 0) as! NSString
        let path = documentsDirectory.appendingPathComponent("ImagesFolder")
        do {
            try fileManager.removeItem(atPath: path)
        } catch let error as NSError {
            print("Could not clear documents folder: \(error.debugDescription)")
        }
    }
}
