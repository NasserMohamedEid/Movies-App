//
//  HomeTableViewCell.swift
//  Movies App
//
//  Created by Nasser Mohamed on 15/07/2022.
//

import UIKit
import SDWebImage
typealias closure=(_ movie:Movie)->()

class HomeTableViewCell: UITableViewCell{
    var onklick:closure?
   
    
    var movies:[Movie]?{
        didSet{
            collectionView.reloadData()
        }
    }
var homeViewController:HomeViewController?
    @IBOutlet var collectionView:UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
    homeViewController=HomeViewController()
        collectionView.delegate=self
        collectionView.dataSource=self
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        

     
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        collectionView.deselectItem(at: indexPath, animated: true)
        let movie=movies?[indexPath.row]
        onklick?(movie!)
    }
    
}
extension HomeTableViewCell:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies?.count ?? 0

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HCCell", for: indexPath) as? HomeCollectionViewCell else {return UICollectionViewCell()}
        
        let url:String=movies?[indexPath.row].poster_path ?? ""
            
            cell.movieImage.sd_setImage(with:URL(string: "https://image.tmdb.org/t/p/w500\(url)"))
            return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
      
        let config=UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { result in
            let downloadAction=UIAction(title: "Download", subtitle: nil, image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { [weak self] _ in
                
                let movie:Movie? = self?.movies?[indexPath.row]

                self?.downloadmovie(movie: movie)
            }
            return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [downloadAction])
        }
        
       
    

        return config
    }
    private func downloadmovie(movie:Movie?){
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

}
