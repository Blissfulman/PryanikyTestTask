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
        
        NetworkService().fetchViewData { result in
            switch result {
            case .success(let model):
                print()
                model.order.forEach { block in
                    guard let blockData = model.blocks.first { $0.type == block }?.data else { return }

                    switch blockData {
                    case .text(data: let data):
                        print(data.text!)
                    case .picture(data: let data):
                        print(data.text!, data.url!)
                    case .selector(data: let data):
                        print(data.selectedID!)
                        print(data.variants!)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
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
