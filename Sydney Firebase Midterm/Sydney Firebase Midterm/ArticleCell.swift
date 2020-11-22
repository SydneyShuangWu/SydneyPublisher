//
//  ArticleCell.swift
//  Sydney Firebase Midterm
//
//  Created by Jovan ho on 2020/11/20.
//

import Foundation
import UIKit

class ArticleCell: UITableViewCell {
  
  @IBOutlet weak var articleTitleLabel: UILabel!
  @IBOutlet weak var authorNameLabel: UILabel!
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var createdTimeLabel: UILabel!
  @IBOutlet weak var articleContentLabel: UILabel!
  
  func setupCellWith(article: Article, createdTime: String) {
    articleTitleLabel.text = article.title
    authorNameLabel.text = article.author.name
    categoryLabel.text = article.category
    createdTimeLabel.text = "\(createdTime)"
    articleContentLabel.text = article.content
  }
  
}
