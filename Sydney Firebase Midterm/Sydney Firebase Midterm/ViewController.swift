//
//  ViewController.swift
//  Sydney Firebase Midterm
//
//  Created by Jovan ho on 2020/11/20.
//

import UIKit
import Firebase
import FirebaseFirestore

class ViewController: UIViewController {
  
  @IBOutlet weak var articlesTableView: UITableView!
  
  var articles = [Article]()
  var db = Firestore.firestore()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    articlesTableView.delegate = self
    articlesTableView.dataSource = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    db.collection("articles").order(by: "createdTime", descending: true)
      .addSnapshotListener { (snapshot, error) in
        guard let snap = snapshot else {
          print("Error fetching snapshots: \(error!)")
          return
        }

        snap.documentChanges.forEach { diff in
          if (diff.type == .added) {
            let data = diff.document.data()
            let author = data["author"] as? String ?? ""
            let title = data["title"] as? String ?? ""
            let content = data["content"] as? String ?? ""
            let category = data["category"] as? String ?? ""
            let createdTime = data["createdTime"] as? Date ?? Date()
            let id = diff.document.documentID
            print("New article: \(diff.document.data())")
            
            let article = Article(author: author, title: title, content: content, createdTime: createdTime, id: id, category: category)
            self.articles.append(article)
            self.articlesTableView.reloadData()
          }
        }
      }
  }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return articles.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let articleCell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell") as! ArticleCell
    
    articleCell.articleTitleLabel.text = articles[indexPath.row].title
    articleCell.articleContentLabel.text = articles[indexPath.row].content
    articleCell.createdTimeLabel.text = "\(articles[indexPath.row].createdTime)"
    articleCell.authorNameLabel.text = articles[indexPath.row].author
    articleCell.categoryLabel.text = articles[indexPath.row].category
    
    return articleCell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//    return UITableView.automaticDimension
    return 150
  }

}

