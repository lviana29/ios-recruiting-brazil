//
//  MovieListIteractor.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 07/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

class MovieListIteractor: PresenterToMovieListIteractorProtocol {
    var presenter: IteractorToMovieListPresenterProtocol?
    let service:MovieListService = MovieListService()
    func loadMovies(page:Int) {
        
        if !Reachability.isConnectedToNetwork() {
            self.presenter?.returnMoviesError(message: Constants.defaultMessageError)
            return
        }
        
        service.getMovies(appKey: Constants.appKey, pageNumber: page) { (result) in
            if result.typeReturnService == .success {
                let objectReturn:MovieListResult = result.objectReturn as! MovieListResult
                self.presenter?.returnMovies(movies: objectReturn.movies, moviesTotal: objectReturn.moviesTotal)
            }
            else {
                self.presenter?.returnMoviesError(message: result.messageReturn!)
            }
        }
    }
    
    func loadGenrers() {
        
        if !Reachability.isConnectedToNetwork() {
            self.presenter?.returnLoadGenrersError(message: Constants.defaultMessageError)
            return
        }
        
        let serviceGenre:GenreService = GenreService()
        serviceGenre.getGenres(appKey: Constants.appKey) { (result) in
            if result.typeReturnService == .success {
                let objectReturn:GenreListData = result.objectReturn as! GenreListData
                self.presenter?.returnLoadGenrers(genres: objectReturn.genres)
            }
            else {
                self.presenter?.returnLoadGenrersError(message: result.messageReturn!)
            }
        }
    }
 
    func loadFavorites() {
        let repositoryFavorite:FavoritesRepository = FavoritesRepository()
        let favoriteList:[FavoritesDetailsData] = repositoryFavorite.loadFavorites(predicate: nil)
        self.presenter?.returnLoadFavorites(favoritemovies: favoriteList)
    }
    
 }
