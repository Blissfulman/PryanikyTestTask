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
    
    var viewModel: MainViewModelProtocol
    
    private let сellGenerator = CellGenerator()
    
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
        
        tableView.register(TextCell.nib(), forCellReuseIdentifier: TextCell.identifier)
        tableView.register(PictureCell.nib(), forCellReuseIdentifier: PictureCell.identifier)
        tableView.register(SelectorCell.nib(), forCellReuseIdentifier: SelectorCell.identifier)
        setupViewModelBindings()
    }
    
    // MARK: - Private methods
    
    private func setupViewModelBindings() {
        viewModel.dataModelDidUpdate = { [weak self] in
            self?.tableView.reloadData()
            
        }
    }
}

// MARK: - Table view data source

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let blockData = viewModel.blockDataForRow(at: indexPath) else { return UITableViewCell() }
        
        return сellGenerator.getCellAtBlockData(blockData, withIndexPath: indexPath, forTableView: tableView)
    }
}

// MARK: - Table view delegate

extension MainViewController: UITableViewDelegate {
    
}
