//
//  ViewController.swift
//  Movies App
//
//  Created by Nasser Mohamed on 14/07/2022.
//

import UIKit

class HomeViewController: UIViewController{
    
    enum section:Int{
        case trendingMovie=0
        case TrendTV=1
        case TopRated=2
        case Popular=3
        case UpComing=4
    }
    func sendd(movie:Movie) {
       
        let secondvc=self.storyboard?.instantiateViewController(withIdentifier: "DetailsMovieViewController") as! DetailsMovieViewController
        secondvc.movie=movie
        self.navigationController?.pushViewController(secondvc, animated: true)
    }
   

    var homeTableViewcel:HomeTableViewCell?
    @IBOutlet weak var homeTableView: UITableView!
    
    @IBOutlet weak var headViewImage: UIImageView!
    var viewModel:ViewModel!
    
    @IBOutlet weak var downloadButton: UIButton!
   
    @IBOutlet weak var playButton: UIButton!
    @IBAction func playButton(_ sender: UIButton) {
 
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headViewImage.image=UIImage(named: "dune")
        homeTableViewcel=HomeTableViewCell()
        viewModel = ViewModel()
       
    }
    
  
    
}



extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = homeTableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as? HomeTableViewCell else {return UITableViewCell()}
        switch indexPath.section{
        case section.trendingMovie.rawValue:
            viewModel.getTrendingMovies()
            
            
        case section.TrendTV.rawValue:
            viewModel.getTrendingTVs()
        case section.TopRated.rawValue:
            viewModel.getTopRated()
        case section.Popular.rawValue:
            viewModel.getPopular()
        case section.UpComing.rawValue:
            viewModel.getUpcomingMovie()
        default:return UITableViewCell()
        }
        viewModel.bindResultToHomeView={
            [weak self]in
            DispatchQueue.main.async {
                cell.movies=self?.viewModel.result
                }
         }
        
        cell.collectionView.tag=indexPath.section
        cell.onklick={movie in
            self.sendd(movie: movie)
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       30
    }
   
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section{
        case 0:return "Trend Movie"
        case 1:return "Trend TV"
        case 2:return "Top Rated"
        case 3:return "Popular"
        default:return "Up coming"
        }

    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header=view as?UITableViewHeaderFooterView else{return}
       
        header.textLabel?.font = .systemFont(ofSize: 18)
        
    }

   
}

