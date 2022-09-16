//
//  DetailsMovieViewController.swift
//  Movies App
//
//  Created by Nasser Mohamed on 15/08/2022.
//

import UIKit
import youtube_ios_player_helper
class DetailsMovieViewController: UIViewController{


    @IBAction func downloadButton(_ sender: UIButton) {
        DataPersistenceManager.shared.downloadTitle(model: movie) { result in
            switch result{
            case.success():
                print("download sucsses")
                break
            case.failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    @IBOutlet weak var MovieName: UILabel!
    var movie:Movie?
    var youtube:videoElement?
    var viewModel:ViewModel!
    @IBOutlet weak var overviewLable: UILabel!
    @IBOutlet var playerView:YTPlayerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overviewLable.text=movie?.overview
        MovieName.text=movie?.original_title ?? movie?.original_name
        viewModel=ViewModel()
        viewModel.bindResultToHomeView={
                [weak self]in
                DispatchQueue.main.async {
                    print(self?.viewModel.resultMovie?[0].id.videoId)
                    self?.playerView.load(withVideoId:self?.viewModel.resultMovie?[0].id.videoId ?? "")
                    }
             }
        viewModel.getMovie(name: "\((movie?.original_title ?? movie?.original_name) ?? "") trailer")
    }

}

