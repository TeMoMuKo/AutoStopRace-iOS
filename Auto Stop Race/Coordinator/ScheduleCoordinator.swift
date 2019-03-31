//
//  ScheduleCoordinator.swift
//  Auto Stop Race
//
//  Created by RI on 26/04/2018.
//  Copyright © 2018 Torianin. All rights reserved.
//

import UIKit
import SKPhotoBrowser
import Kingfisher

final class ScheduleCoordinator: Coordinator {

    var baseViewController: ApplicationViewController

    init(baseViewController: ApplicationViewController ) {
        self.baseViewController = baseViewController
    }

    func start() {
        guard let url = URL(string: ApiConfig.assetsJsonUrl),
            let raceInfoImages = try? RaceInfoImages(fromURL: url),
            let scheduleImageUrl = URL(string: raceInfoImages.scheduleImageUrl) else { return }
        var images = [SKPhoto]()
        KingfisherManager.shared.retrieveImage(with: scheduleImageUrl, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                let photo = SKPhoto.photoWithImage(value.image)
                images.append(photo)
                let browser = SKPhotoBrowser(photos: images)
                browser.initializePageIndex(0)
                self.baseViewController.present(browser, animated: true)
                print("Image: \(value.image). Got from: \(value.cacheType)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
