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
    var resultTv : [Movie]?{
        didSet{
            bindResultToHomeView()
        }
    }
    var resultTop : [Movie]?{
        didSet{
            bindResultToHomeView()
        }
    }
    var resultUpcoming : [Movie]?{
        didSet{
            bindResultToHomeView()
        }
    }
    var resultPopular : [Movie]?{
        didSet{
            bindResultToHomeView()
        }
    }
    var resultTopSearch : [Movie]?{
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
                self.resultTv=result
        }}
    
    func getTopRated(){
                APICaller.shared.getTopRated { result in
                    self.resultTop=result
        }}
    
    func getUpcomingMovie(){
                    APICaller.shared.getUpcomingMovie { result in
                        self.resultUpcoming=result
        }}
    
    func getPopular(){
                    APICaller.shared.getPopular { result in
                        self.resultPopular=result
        }}

    func getTopSearch(){
                    APICaller.shared.getPopular { result in
                        self.resultTopSearch=result
        }}
}
