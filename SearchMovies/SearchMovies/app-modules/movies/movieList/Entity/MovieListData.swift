//
//  MovieListData.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 07/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation
 
struct MovieListData {
    var id:Int
    var name:String
    var isFavorite:Bool
    var imageUrl:String
    var genreIds:[Int]
    
    init(id:Int, name:String, isFavorite:Bool, imageUrl:String, genreIds:[Int]) {
        self.id = id
        self.name = name
        self.isFavorite = isFavorite
        self.imageUrl = imageUrl
        self.genreIds = genreIds
    }
}

extension MovieListData :Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case imageUrl = "poster_path"
        case genreIds = "genre_ids"
    }
    
    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let codeDecodable = try container.decode(Int.self, forKey: .id)
        let nameDecodable = try container.decode(String.self, forKey: .name)
        let urlDecodable = try container.decode(String.self, forKey: .imageUrl)
        let genreIdsDecodable = try container.decode([Int].self, forKey: .genreIds)
        
        self.init(id: codeDecodable, name: nameDecodable, isFavorite: false, imageUrl: urlDecodable, genreIds: genreIdsDecodable)
    }
    
}
