//
//  youtubeModel.swift
//  Movies App
//
//  Created by Nasser Mohamed on 15/08/2022.
//

import Foundation
struct youtubeSearchResponse:Decodable{
    let items:[videoElement]
}
struct videoElement:Decodable{
    let id :IdVideoElement
}
struct IdVideoElement:Decodable{
    let kind:String
    let videoId:String
}
