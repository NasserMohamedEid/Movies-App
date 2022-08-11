//
//  SearchViewController.swift
//  Movies App
//
//  Created by Nasser Mohamed on 11/08/2022.
//

import UIKit
import SDWebImage
class SearchViewController: UIViewController {

    @IBOutlet weak var searhTableView: UITableView!
    var viewModel:ViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel=ViewModel()
        viewModel.bindResultToHomeView={
                [weak self]in
                DispatchQueue.main.async {
                self?.searhTableView.reloadData()
                    }
             }
        viewModel.getTopSearch()
    }

}
extension SearchViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.resultTopSearch?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as? SearchTableViewCell else {return UITableViewCell()}
        let url:String=viewModel.resultTopSearch?[indexPath.row].poster_path ?? ""
        cell.imageSearch.sd_setImage(with:URL(string:"https://image.tmdb.org/t/p/w500\(url)"))
//        print(url)
        cell.movieName.text=viewModel.resultTopSearch?[indexPath.row].original_title ?? ""
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Search"
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header=view as?UITableViewHeaderFooterView else{return}
        header.textLabel?.textColor = .white
        header.textLabel?.font = .systemFont(ofSize: 30)
        header.sizeToFit()
    }

    
}
