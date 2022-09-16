//
//  CommingSoonViewController.swift
//  Movies App
//
//  Created by Nasser Mohamed on 06/08/2022.
//

import UIKit

class CommingSoonViewController: UIViewController {
    var viewModel:ViewModel!
    @IBOutlet weak var commingTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title="Comming Soon"
        viewModel=ViewModel()
        viewModel.bindResultToHomeView={
                [weak self]in
                DispatchQueue.main.async {
                self?.commingTableView.reloadData()
                    }
             }
        viewModel.getUpcomingMovie()
    }

}
extension CommingSoonViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.result?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = commingTableView.dequeueReusableCell(withIdentifier: "commingCell", for: indexPath) as? commingTableViewCell else {return UITableViewCell()}
        let url=viewModel.result?[indexPath.row].poster_path ?? ""
        let name=viewModel.result?[indexPath.row].original_title ?? ""
        cell.commingSetup(url: url, name: name)
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
        secondvc.movie=viewModel.result?[indexPath.row]
        self.navigationController?.pushViewController(secondvc, animated: true)
    }
}
