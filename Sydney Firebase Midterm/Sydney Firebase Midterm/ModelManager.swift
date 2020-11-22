//
//  ModelManager.swift
//  Sydney Firebase Midterm
//
//  Created by Jovan ho on 2020/11/20.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class ModelManager {
  
  let articles = Firestore.firestore().collection("articles")
  
  func addArticle(article: Article) {
      
    let document = articles.document()
      
    let data: [String : Any] = [
      "author" : [
        "name" : article.author.name,
        "email" : article.author.email,
        "id" : article.author.id
      ],
      "title" : article.title,
      "content" : article.content,
      "category" : article.category,
      "createdTime" : NSDate().timeIntervalSince1970,
      "id" : document.documentID
    ]
      
    document.setData(data)
  }
  
  
  func listenArticles(completion: @escaping ([Article], [String]) -> ()) {
    
    var articlesFetched = [Article]()
    var timesFetched = [String]()
    
    articles.addSnapshotListener { (snapshot, error) in
        guard let documents = snapshot else {
          print("Error fetching articles: \(error!)")
          return
        }
        
        _ = documents.documentChanges.map {
          
          guard let article = try? $0.document.data(as: Article.self, decoder: .none),
                let createdTime = $0.document.data()["createdTime"] as? Double
          else { return }
         
          print("🤡 New article: \(article)")
          
          // Convert time from Double to String
          let timeInterval = TimeInterval(createdTime)
          let date = Date(timeIntervalSince1970: timeInterval)
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
          let currentTime = dateFormatter.string(from: date)
          print("Current Time:\(currentTime)")
          
          articlesFetched.insert(article, at: 0)
          timesFetched.insert(currentTime, at: 0)
          completion(articlesFetched, timesFetched)
        }
      }
  }

  
}
