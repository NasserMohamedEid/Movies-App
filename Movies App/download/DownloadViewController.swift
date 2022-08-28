//
//  DownloadViewController.swift
//  Movies App
//
//  Created by Nasser Mohamed on 24/08/2022.
//

import UIKit
import SDWebImage
class DownloadViewController: UIViewController {
  
    var movies=[Movie]()

    @IBOutlet weak var downloadTableView: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        title="Download"
                downloadTableView.dataSource=self
        downloadTableView.delegate=self
        
      
        
    }
    override func viewWillAppear(_ animated: Bool) {
        fetclocalstorageforDownload()
    }
    
    private func fetclocalstorageforDownload(){
        movies=DataPersistenceManager.shared.fetchingTitlefromData()
        
        print(movies.count)
        self.downloadTableView.reloadData()
     
    }
  

}
extension DownloadViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "downloadCell", for: indexPath) as? DownloadTableViewCell else {return UITableViewCell()}
        let url=movies[indexPath.row].poster_path ?? ""
        cell.movieImage.sd_setImage(with:URL(string: "https://image.tmdb.org/t/p/w500\(url)" ))
        cell.nameLable.text=movies[indexPath.row].original_title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondvc=self.storyboard?.instantiateViewController(withIdentifier: "DetailsMovieViewController") as! DetailsMovieViewController
        secondvc.movie=movies[indexPath.row]
        self.navigationController?.pushViewController(secondvc, animated: true)
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }


    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
           print("Deleted")
            self.downloadTableView.beginUpdates()
        DataPersistenceManager.shared.deleteMovie(index: indexPath.row)
            movies.remove(at: indexPath.row)
            self.downloadTableView.deleteRows(at: [indexPath], with: .automatic)
            self.downloadTableView.endUpdates()

        }


    }

 
    
    
}
