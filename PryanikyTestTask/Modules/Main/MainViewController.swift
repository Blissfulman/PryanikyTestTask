//
//  MainViewController.swift
//  PryanikyTestTask
//
//  Created by Evgeny Novgorodov on 11.03.2021.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    let viewModel: MainViewModelProtocol
    
    // MARK: - Initializers
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    // MARK: - Private methods
}

// MARK: - Table view data source

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }
}

// MARK: - Table view delegate

extension MainViewController: UITableViewDelegate {
    
}
