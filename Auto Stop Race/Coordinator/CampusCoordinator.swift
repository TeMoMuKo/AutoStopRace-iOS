//
//  CampusCoordinator.swift
//  Auto Stop Race
//
//  Created by RI on 26/04/2018.
//  Copyright © 2018 Torianin. All rights reserved.
//

import UIKit
import SKPhotoBrowser

final class CampusCoordinator: Coordinator {

    var baseViewController: ApplicationViewController

    init(baseViewController: ApplicationViewController ) {
        self.baseViewController = baseViewController
    }

    func start() {
        guard let url = URL(string: ApiConfig.assetsJsonUrl) else { return }
        guard let imageAssets = try? AssetsInfo(fromURL: url) else { return }
        var images = [SKPhoto]()
        let photo = SKPhoto.photoWithImageURL(imageAssets.campusMap)
        photo.shouldCachePhotoURLImage = true
        images.append(photo)
        let browser = SKPhotoBrowser(photos: images)
        browser.initializePageIndex(0)
        baseViewController.present(browser, animated: true)
    }
}
