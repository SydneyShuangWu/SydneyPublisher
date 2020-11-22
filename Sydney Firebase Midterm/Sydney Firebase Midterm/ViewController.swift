//
//  ViewController.swift
//  Sydney Firebase Midterm
//
//  Created by Jovan ho on 2020/11/20.
//

import UIKit
import FirebaseFirestore
import ESPullToRefresh

class ViewController: UIViewController {
  
  @IBOutlet weak var articlesTableView: UITableView!
  
  var db = Firestore.firestore()
  let manager = ModelManager()
  var myArticles = [Article]()
  var myCreatedTimes = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    fetchArticles()
  }
  
  func setupTableView() {
    articlesTableView.delegate = self
    articlesTableView.dataSource = self
  }
  
  func fetchArticles() {
    manager.listenArticles(completion: { [weak self] articles, createdTimes in
      self?.myArticles = articles
      self?.myCreatedTimes = createdTimes
      self?.articlesTableView.reloadData()
    })
  }
  
}
  

extension ViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return myArticles.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let articleCell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell") as! ArticleCell
    
    articleCell.setupCellWith(article: myArticles[indexPath.row], createdTime: myCreatedTimes[indexPath.row])

    return articleCell
  }
}


