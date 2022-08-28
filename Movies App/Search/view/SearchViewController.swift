//
//  SearchViewController.swift
//  Movies App
//
//  Created by Nasser Mohamed on 11/08/2022.
//

import UIKit
import SDWebImage
class SearchViewController: UIViewController ,UISearchBarDelegate{
    
    var ids:videoElement?
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searhTableView: UITableView!
    var movie:[Movie]=[]
    var viewModel:ViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
title="Search"
        searchBar.delegate=self
        viewModel=ViewModel()
        viewModel.bindResultToHomeView={
                [weak self]in
                DispatchQueue.main.async {
                    self?.movie=(self?.viewModel.resultTopSearch!)!
                self?.searhTableView.reloadData()
                    }
             }
        viewModel.getTopSearch()
    }

}
extension SearchViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as? SearchTableViewCell else {return UITableViewCell()}
        let url:String=movie[indexPath.row].poster_path ?? ""
        cell.imageSearch.sd_setImage(with:URL(string:"https://image.tmdb.org/t/p/w500\(url)"))
//        print(url)
        cell.movieName.text=movie[indexPath.row].original_title ?? ""
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
   
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header=view as?UITableViewHeaderFooterView else{return}
        header.textLabel?.textColor = .white
        header.textLabel?.font = .systemFont(ofSize: 30)
        header.sizeToFit()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondvc=self.storyboard?.instantiateViewController(withIdentifier: "DetailsMovieViewController") as! DetailsMovieViewController
        secondvc.movie=movie[indexPath.row]
        self.navigationController?.pushViewController(secondvc, animated: true)
    }
//MARK: - Searc bar config
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        movie=[]
        if searchText==""{
            self.movie=self.viewModel.resultTopSearch!
        }
        else {
            viewModel.bindResultToHomeView={
                    [weak self]in
                    DispatchQueue.main.async {
                        self?.movie=(self?.viewModel.resultSearch!)!
                    self?.searhTableView.reloadData()
                        }
                 }
            viewModel.getSearch(name: searchText)
        }
        self.searhTableView.reloadData()

    }
    
}
