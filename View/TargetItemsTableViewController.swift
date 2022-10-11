//
//  TargetItemsTableViewController.swift
//  TargetAPI
//
//  Created by Isiah Parra on 10/7/22.
//

import UIKit

class TargetItemsTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchList: [SearchResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as? ItemsToDisplayCell else { return UITableViewCell()}
        let searchItem = searchList[indexPath.row]
        cell.updateViews(with: searchItem.product)
        return cell
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "targetVC",
              let indexPath = tableView.indexPathForSelectedRow,
              let destination = segue.destination as?
                SearchedItemViewController else { return }
        let itemToSend = searchList[indexPath.row].product
        destination.product = itemToSend
    }
    
    
}// end of class

extension TargetItemsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        NetworkController.fetchItems(with: searchText) { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.searchList = items
                    self.tableView.reloadData()
                }
            case .failure(let error):
                // Make an alert pop up when error has happened
                print("There has been an error fetching searched items", error.localizedDescription)
            }
        }
    }
}
