//
//  HomeTableViewCell.swift
//  Movies App
//
//  Created by Nasser Mohamed on 15/07/2022.
//

import UIKit
import SDWebImage
typealias closure=(_ movie:Movie)->()
var x=0
var y=0
class HomeTableViewCell: UITableViewCell{
    var onklick:closure?
   
    
    var viewModel:ViewModel!
var homeViewController:HomeViewController?
    @IBOutlet var collectionView:UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
    homeViewController=HomeViewController()
        collectionView.delegate=self
        collectionView.dataSource=self
        viewModel=ViewModel()
        viewModel.bindResultToHomeView={
                [weak self]in
                DispatchQueue.main.async {
                self?.collectionView.reloadData()
                    }
             }
        getmovie()
    }
    func getmovie(){
        switch x{
        case 0:x=1
            y=0
            viewModel.getTrendingMovies()
            
            break
        case 1:
            y=1
            x=2
            viewModel.getUpcomingMovie()
            
            break
        case 2:x=3
            y=2
            viewModel.getTopRated()
            
            break
        case 3:
            x=4
            y=3
            viewModel.getPopular()
            break
        default:
            y=4
            viewModel.getTrendingTVs()
            
            break
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        

     
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

//        print(indexPath.section)
        let movie:Movie?
        switch collectionView.tag{
        case 0:movie=viewModel.result?[indexPath.row]
            break
        case 1:movie=viewModel.resultUpcoming?[indexPath.row]
            
            break
        case 2:movie=viewModel.resultTop?[indexPath.row]
            
            break
        case 3:movie=viewModel.resultPopular?[indexPath.row]
            break
        default:
            movie=viewModel.resultTv?[indexPath.row]
break
        }
        onklick?(movie!)
    }
    
}
extension HomeTableViewCell:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if y==0{
        return viewModel.result?.count ?? 0
        }
        else if y==1{return viewModel.resultUpcoming?.count ?? 0}
        else if y==2{return viewModel.resultTop?.count ?? 0}
        else if y==3{return viewModel.resultPopular?.count ?? 0}
        else{return viewModel.resultTv?.count ?? 0}

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HCCell", for: indexPath) as? HomeCollectionViewCell else {return UICollectionViewCell()}
        
        switch collectionView.tag{
        case 0:let url:String=viewModel.result?[indexPath.row].poster_path ?? ""
            
            cell.movieImage.sd_setImage(with:URL(string: "https://image.tmdb.org/t/p/w500\(url)"))
            return cell
        case 1:let url:String=viewModel.resultUpcoming?[indexPath.row].poster_path ?? ""
            cell.movieImage.sd_setImage(with:URL(string: "https://image.tmdb.org/t/p/w500\(url)"))
            return cell
        case 2:let url:String=viewModel.resultTop?[indexPath.row].poster_path ?? ""
            
            cell.movieImage.sd_setImage(with:URL(string: "https://image.tmdb.org/t/p/w500\(url)"))
            return cell
        case 3:let url:String=viewModel.resultPopular?[indexPath.row].poster_path ?? ""
            cell.movieImage.sd_setImage(with:URL(string: "https://image.tmdb.org/t/p/w500\(url)"))
            return cell
        default:let url:String=viewModel.resultTv?[indexPath.row].poster_path ?? ""
                        cell.movieImage.sd_setImage(with:URL(string: "https://image.tmdb.org/t/p/w500\(url)"))
                        return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config=UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { result in
            let downloadAction=UIAction(title: "Download", subtitle: nil, image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                let movie:Movie?
                switch collectionView.tag{
                case 0:movie=self.viewModel.result?[indexPath.row]
                    break
                case 1:movie=self.viewModel.resultUpcoming?[indexPath.row]
                    
                    break
                case 2:movie=self.viewModel.resultTop?[indexPath.row]
                    
                    break
                case 3:movie=self.viewModel.resultPopular?[indexPath.row]
                    break
                default:
                    movie=self.viewModel.resultTv?[indexPath.row]
        break
                }
                
            }
            
          
            return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [downloadAction])
        }
      
        return config
    }
   

}
