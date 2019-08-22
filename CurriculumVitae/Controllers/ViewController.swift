//
//  MainViewController.swift
//  CurriculumVitae
//
//  Created by Apocalapsus on 17/08/19.
//  Copyright © 2019 Carlos. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: MainViewControllerViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Subscribe to new data updates
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(newCVDataAvailable),
                                               name: DataLauncher.didDownloadDataNotification,
                                               object: nil)
        // Register cells
        self.tableView.register(UINib(nibName: "ProfileCell", bundle: nil), forCellReuseIdentifier: ProfileCell.cellIdentifier)
        self.tableView.register(UINib(nibName: "ContactCell", bundle: nil), forCellReuseIdentifier: ContactCell.cellIdentifier)
        self.tableView.register(UINib(nibName: "SkillCell", bundle: nil), forCellReuseIdentifier: SkillCell.cellIdentifier)
        self.tableView.register(UINib(nibName: "WorkCell", bundle: nil), forCellReuseIdentifier: WorkCell.cellIdentifier)
        self.tableView.register(UINib(nibName: "ReferenceCell", bundle: nil), forCellReuseIdentifier: ReferenceCell.cellIdentifier)
        self.tableView.register(UINib(nibName: "EducationCell", bundle: nil), forCellReuseIdentifier: EducationCell.cellIdentifier)
        self.tableView.register(UINib(nibName: "InterestCell", bundle: nil), forCellReuseIdentifier: InterestCell.cellIdentifier)
    }
        
    @objc func newCVDataAvailable() {
        do {
            // Recuperate data from DB
            if let curriculum = try DataLauncher.shared.coreDataHandler?.getCurriculum() {
                // Initialize view model and send data to populate cells
                self.viewModel = MainViewControllerViewModel(curriculum: curriculum)
                self.reloadUI()
            }
        } catch {
            self.displayErrorMessage("Some error happened to load the application's data.")
            print("Exception caught: \(error)")
        }
    }
    
    // Procurate to run UI updates on main thread
    func reloadUI() {
        DispatchQueue.main.async {
            self.tableView.dataSource = self.viewModel
            self.tableView.reloadData()
        }
    }
}

