//
//  Model.swift
//  Movies App
//
//  Created by Nasser Mohamed on 20/07/2022.
//

import Foundation
struct TrendingMoviesReponse:Decodable{
    let results:[Movie]
}
struct Movie:Decodable{
    let id:Int?
    let original_title:String?
    let original_name:String?
    let title:String?
    let media_type:String?
    let overview:String?
    let poster_path:String?
    let release_date:String?
    let vote_count:Int?
    let vote_average:Double?
}
