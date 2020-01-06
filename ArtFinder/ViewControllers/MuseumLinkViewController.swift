//
//  MuseumLinkViewController.swift
//  ArtFinder
//
//  Created by casandra grullon on 1/6/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import SafariServices

class MuseumLinkViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        showMuseum()
    }

    func showMuseum(){
        guard let url = URL(string: "http://www.louvre.fr/en/homepage") else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
        safariVC.delegate = self
    }
    
}
extension MuseumLinkViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
