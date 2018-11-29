//
//  SettingViewController.swift
//  HNote
//
//  Created by 洪伟辉 on 2018/11/27.
//  Copyright © 2018 hongweihui. All rights reserved.
//

import Foundation
import UIKit

class SettingViewController: UITableViewController, UIGestureRecognizerDelegate, UIDocumentPickerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "Setting"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    @IBAction func infoAlert(_ sender: Any) {
        showAlert(msg: "HNote v1.0")
    }
    @IBAction func updateAlert(_ sender: Any) {
        showAlert(msg: "The latest version")
    }
    
    func showAlert(msg: String) {
        let alertController = UIAlertController.init(title: "About", message: msg, preferredStyle:.alert)
        let cancel = UIAlertAction.init(title: "OK", style: UIAlertAction.Style.cancel)
        alertController.addAction(cancel);
        self.present(alertController, animated: true, completion: nil)
    }
}
