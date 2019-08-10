//
//  FavoritesListViewController.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 09/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import UIKit

class FavoritesListViewController: BaseViewController {
    //MARK: Properties
    var presenter:ViewToFavoritesListPresenterProtocol?
    private var favoritesList:[FavoritesDetailsData]!
    private var cellIdentifier:String = "cellItem"
    private var filteredData:[FavoritesDetailsData]!
    private var isFiltered:Bool = false
    //MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var display: DisplayInformationView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightFilterConstraint: NSLayoutConstraint!
    
    //MARK:Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        FavoritesListRouter.setModule(self)
        self.searchBar.styleDefault()
        self.navigationController?.navigationBar.styleDefault()
        self.favoritesList = [FavoritesDetailsData]()
        self.filteredData = [FavoritesDetailsData]()
        self.hidePainelView(painelView: self.display, contentView: self.viewContent)
        self.tableView.register(UINib(nibName: "FavoritesTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: cellIdentifier)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.heightFilterConstraint.constant = 0
        self.showActivityIndicator()
        self.presenter?.loadFavorites()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FavoritesListViewController: PresenterToFavoritesListViewProtocol {
    func returnFavorites(favorites: [FavoritesDetailsData]) {
        self.hideActivityIndicator()
        DispatchQueue.main.async {
            self.favoritesList = favorites
            
            self.hidePainelView(painelView: self.display, contentView: self.viewContent)
            
            if self.favoritesList.count == 0 {
                self.showPainelView(painelView: self.display, contentView: self.viewContent, description: "Não há filmes adicionados em seu favoritos", typeReturn: .success)
                return
            }
            
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
        }
    }
    
    func returnFavoritesError(message: String) {
         self.showPainelView(painelView: self.display, contentView: self.viewContent, description: message, typeReturn: .error)
    }
}

extension FavoritesListViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoritesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FavoritesTableViewCell = (tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FavoritesTableViewCell)
        let favorite:FavoritesDetailsData = self.isFiltered ? self.filteredData[indexPath.row] : self.favoritesList[indexPath.row]
        
        cell.fill(name: favorite.name, descripton: favorite.overView, year: String(favorite.year), imageIconUrl: favorite.posterPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
}
