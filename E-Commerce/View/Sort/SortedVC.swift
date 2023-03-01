//
//  SortedVC.swift
//  E-Commerce
//
//  Created by Tolba Hamdi on 2/28/23.
//

import UIKit

class SortedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortedView: UIView! {
        didSet {
            sortedView.layer.cornerRadius = 10
        }
    }
    
    private let sortedItem: [String] = ["Popular", "Newest", "Customer Review", "Price: highest to low"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    @IBAction func dismissBtnTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

//MARK: - Private Methods
extension SortedVC {
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: - TableView delegate & datasource
extension SortedVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.sortTableViewCell) as! SortTableViewCell
        
        cell.sortedNameLabel.text = sortedItem[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! SortTableViewCell
        cell.selectedBackgroundView = UIView()
        cell.selectedBackgroundView?.backgroundColor = .red
        cell.sortedNameLabel.textColor = .white
        cell.sortedNameLabel.font = UIFont(name: "Roboto-Bold", size: 20)
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SortTableViewCell
        cell.sortedNameLabel.textColor = .black
        cell.sortedNameLabel.font = UIFont(name: "Roboto-Regular", size: 16)
    }
   
}
