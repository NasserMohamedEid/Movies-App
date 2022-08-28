//
//  APICaller.swift
//  Movies App
//
//  Created by Nasser Mohamed on 20/07/2022.
//

import Foundation
import Alamofire
struct constant{
    static let apiKey="d34d5ae176707ff2d42e9432ea54059f"
    static let baseUrl="https://api.themoviedb.org"
    static let youtubeapi_Key="AIzaSyA-Mm4YwCq0gViJZPw4hIxQuCisFb57ZD4"
    static let youtube_baseUrl="https://youtube.googleapis.com/youtube/v3/search?"
}
class APICaller{
    static let shared = APICaller()
    
    func getTrendingMovie(complition:@escaping ([Movie])->Void){
        guard let url=URL(string: "\(constant.baseUrl)/3/trending/movie/day?api_key=\(constant.apiKey)")else {return}
        AF.request(url).responseDecodable(of:TrendingMoviesReponse.self){
                    response in
                    guard let data=response.value else{return}
            
            complition(data.results)
                }
        
    }
    func getTrendingTVs(complition:@escaping ([Movie])->Void){
        guard let url=URL(string: "\(constant.baseUrl)/3/trending/tv/day?api_key=\(constant.apiKey)")else {return}
        AF.request(url).responseDecodable(of:TrendingMoviesReponse.self){
                    response in
                    guard let data=response.value else{return}
          
            complition(data.results)
                }
        
    }
    func getTopRated(complition:@escaping ([Movie])->Void){
        guard let url=URL(string: "\(constant.baseUrl)/3/movie/top_rated?api_key=\(constant.apiKey)&language=en-US&page=1")else {return}
        AF.request(url).responseDecodable(of:TrendingMoviesReponse.self){
                    response in
                    guard let data=response.value else{return}
          
            complition(data.results)
                }
        
    }
    func getUpcomingMovie(complition:@escaping ([Movie])->Void){
        guard let url=URL(string: "\(constant.baseUrl)/3/movie/upcoming?api_key=\(constant.apiKey)&language=en-US&page=1")else {return}
        AF.request(url).responseDecodable(of:TrendingMoviesReponse.self){
                    response in
                    guard let data=response.value else{return}
           
            complition(data.results)
                }
        
    }
    func getPopular(complition:@escaping ([Movie])->Void){
        guard let url=URL(string: "\(constant.baseUrl)/3/movie/popular?api_key=\(constant.apiKey)&language=en-US&page=1")else {return}
        AF.request(url).responseDecodable(of:TrendingMoviesReponse.self){
                    response in
                    guard let data=response.value else{return}
         
            complition(data.results)
                }
        
    }
   
 //https://api.themoviedb.org/3/discover/movie?api_key=<<api_key>>&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate
    func getTopSearch(complition:@escaping ([Movie])->Void){
        guard let url=URL(string: "\(constant.baseUrl)/3/movie/popular?api_key=\(constant.apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate")else {return}
        AF.request(url).responseDecodable(of:TrendingMoviesReponse.self){
                    response in
                    guard let data=response.value else{return}
         
            complition(data.results)
                }
        
    }
    func getSearch(name:String,complition:@escaping ([Movie])->Void){
        guard let name=name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)else{return}
        guard let url=URL(string: "\(constant.baseUrl)/3/search/movie?api_key=\(constant.apiKey)&query=\(name)")else {return}
        AF.request(url).responseDecodable(of:TrendingMoviesReponse.self){
                    response in
                    guard let data=response.value else{return}
         
            complition(data.results)
                }
        
    }
    func getmovie(name:String,complition:@escaping ([videoElement])->Void){
        guard let name=name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)else{return}
        guard let url=URL(string: "\(constant.youtube_baseUrl)q=\(name)&key=\(constant.youtubeapi_Key)")else {return}
        AF.request(url).responseDecodable(of:youtubeSearchResponse.self){
                    response in
                    guard let data=response.value else{return}
            print(data.items)
            
                complition(data.items)
                }
        
    }
    
}
