//
//  DataPersistenceManager.swift
//  Movies App
//
//  Created by Nasser Mohamed on 23/08/2022.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager{
    static let shared=DataPersistenceManager()
    enum DatabaseError{
        case failedToSaveData
    }
    func downloadTitle(model:Movie?,completion:@escaping(Result<Void,Error>)->Void){
        guard let appdelegate=UIApplication.shared.delegate as? AppDelegate else{return}
        let context=appdelegate.persistentContainer.viewContext
        guard let movieEntity=NSEntityDescription.entity(forEntityName: "TitleItem", in: context)else{return}
        let movieObject=NSManagedObject.init(entity: movieEntity, insertInto: context)
        movieObject.setValue(model?.poster_path, forKey: "poster_path")
        movieObject.setValue(model?.title, forKey: "title")
        movieObject.setValue(model?.original_title, forKey: "original_title")
        movieObject.setValue(model?.original_name, forKey: "original_name")
        
        movieObject.setValue(model?.overview, forKey: "overview")
        movieObject.setValue(model?.vote_count, forKey: "vote_count")
        movieObject.setValue(model?.media_type, forKey: "media_type")
        movieObject.setValue(model?.release_date, forKey: "release_date")
        movieObject.setValue(model?.id, forKey: "id")
        movieObject.setValue(model?.vote_average, forKey: "vote_average")
        
        do{
            
            try context.save()
            completion(.success(()))
            
        }catch{
            completion(.failure(DatabaseError.failedToSaveData as! Error))
        }
    }
    func fetchingTitlefromData()->[Movie]{
        var movies:[Movie]=[]
        guard let appdelegate=UIApplication.shared.delegate as? AppDelegate else{return []}
        let context=appdelegate.persistentContainer.viewContext
        
        let fetchRequest=NSFetchRequest<NSFetchRequestResult>(entityName: "TitleItem")
        do {
            let result = try context.fetch(fetchRequest)as! [NSManagedObject]
            for manageMovie in result{
                let title=manageMovie.value(forKey: "title") as? String
                let original_title=manageMovie.value(forKey: "original_title")as?String
                let original_name=manageMovie.value(forKey:"original_name")as?String
                let poster_path=manageMovie.value(forKey: "poster_path")as?String
                
                let overview=manageMovie.value(forKey: "overview") as? String
                let vote_count=manageMovie.value(forKey: "vote_count")as?Int
                let media_type=manageMovie.value(forKey:"media_type")as?String
                let id=manageMovie.value(forKey: "id")as?Int
                let release_date=manageMovie.value(forKey:"release_date")as?String
                let vote_average=manageMovie.value(forKey: "vote_average")as?Double
                let movie=Movie(id: id, original_title: original_title, original_name: original_name, title: title, media_type: media_type, overview: overview, poster_path: poster_path ?? "", release_date: release_date, vote_count: vote_count, vote_average: vote_average)
                movies.append(movie)
            }
        }catch{
            
        }
        
    return movies
}
    func deleteMovie(index:Int){
        guard let appdelegate=UIApplication.shared.delegate as? AppDelegate else{return}
        let context=appdelegate.persistentContainer.viewContext
        
        let fetchRequest=NSFetchRequest<NSFetchRequestResult>(entityName: "TitleItem")
        do {
            let result = try context.fetch(fetchRequest)as! [NSManagedObject]
            let moviedelete=result[index]
            context.delete(moviedelete)
            try context.save()
        }catch{
            
        }
    }
    
}
