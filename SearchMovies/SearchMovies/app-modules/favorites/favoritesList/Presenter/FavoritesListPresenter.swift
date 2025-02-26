//
//  BookMarkListPresenter.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 09/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

class FavoritesListPresenter: ViewToFavoritesListPresenterProtocol {
    var view: PresenterToFavoritesListViewProtocol?
    
    var iteractor: PresenterToFavoritesListIteractorProtocol?
    
    var route: PresenterToFavoritesListRouterProtocol?
    
    func loadFavorites() {
        self.iteractor?.loadFavorites()
    }
    
    func remove(favorite: FavoritesDetailsData) {
        self.iteractor?.remove(favorite: favorite)
    }
    
    func mapObjectFilter(favorites:[FavoritesDetailsData]) {
        let resultGenres:[FilterResultData] = (SingletonProperties.shared.genres?.map { result in
            return FilterResultData(id: result.id, value: result.name, parentId: 1)
            })!
        var resultDate:[FilterResultData] = favorites.map { result in
            return FilterResultData(id: result.id, value: String(result.year), parentId: 2)
        }
        
        resultDate = resultDate.unique { $0.value }
        let listFilter:[FilterSelectData] = [FilterSelectData(id: 1, filterName: "Date", filterValue: "", filterEntityName: "year", resultData: resultDate),
                                             FilterSelectData(id: 2, filterName: "Genres", filterValue: "", filterEntityName: "genres", resultData: resultGenres)]
        
        self.view?.returnMapObjectFilter(filter: listFilter)
    }
    
    func applyFilter(filters: [FilterReturn]) {
        self.iteractor?.applyFilter(filters: filters)
    }
}

extension FavoritesListPresenter : IteractorToFavoritesListPresenterProtocol {
    func returnFavorites(favorites: [FavoritesDetailsData]) {
        self.view?.returnFavorites(favorites: favorites)
    }
    
    func returnFavoritesError(message: String) {
        self.view?.returnFavoritesError(message: message)
    }
    
    func returnRemoveFavorites() {
        self.view?.returnRemoveFavorites()
    }
    
    func returnRemoveFavoritesError(message: String) {
        self.view?.returnFavoritesError(message: message)
    }
    
    func returnApplyFilter(favorites: [FavoritesDetailsData]) {
        self.view?.returnApplyFilter(favorites: favorites)
    }
}
