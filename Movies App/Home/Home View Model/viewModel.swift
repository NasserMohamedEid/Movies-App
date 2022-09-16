//
//  viewModel.swift
//  Movies App
//
//  Created by Nasser Mohamed on 21/07/2022.
//

import Foundation
class ViewModel {
    
    
    var bindResultToHomeView : (() -> ()) = {}
    
    
    var result : [Movie]?{
        didSet{
            bindResultToHomeView()
        }
    }
   
    var resultSearch : [Movie]?{
        didSet{
            bindResultToHomeView()
        }
    }
    var resultMovie: [videoElement]?{
        didSet{
            bindResultToHomeView()
        }
    }
    
    
    
   
    func getTrendingMovies(){
        APICaller.shared.getTrendingMovie { result in
            self.result=result
        }}
    
    func getTrendingTVs(){
            APICaller.shared.getTrendingTVs { result in
                self.result=result
        }}
    
    func getTopRated(){
                APICaller.shared.getTopRated { result in
                    self.result=result
        }}
    
    func getUpcomingMovie(){
                    APICaller.shared.getUpcomingMovie { result in
                        self.result=result
        }}
    
    func getPopular(){
                    APICaller.shared.getPopular { result in
                        self.result=result
        }}

    func getTopSearch(){
                    APICaller.shared.getPopular { result in
                        self.result=result
        }}
    func getSearch(name:String){
        APICaller.shared.getSearch(name: name) { result in
            self.resultSearch=result
        }
        }
    func getMovie(name:String){
        APICaller.shared.getmovie(name: name) { result in
            self.resultMovie=result
        }
        }
}
