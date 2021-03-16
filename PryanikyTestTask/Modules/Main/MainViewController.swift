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
    
    private let сellGeneratorService = CellGeneratingService()
    
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
        guard let blockData = viewModel.getBlockDataForRow(at: indexPath) else { return UITableViewCell() }
        
        return сellGeneratorService.getCellAtBlockData(blockData, withIndexPath: indexPath,
                                                        forTableView: tableView, delegate: self)
    }
}

// MARK: - Table view delegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCell = tableView.cellForRow(at: indexPath),
              let blockDescriprion = viewModel.getBlockDescription(at: indexPath) else { return }
        
        selectedCell.setSelected(false, animated: true)
        showActionDescription(type: blockDescriprion.type, message: blockDescriprion.message)
    }
}

// MARK: - SelectorCellViewModelDelegate

extension MainViewController: SelectorCellViewModelDelegate {
    
    func showDescriprion(type: BlockType, message: String) {
        showActionDescription(type: type, message: message)
    }
}
