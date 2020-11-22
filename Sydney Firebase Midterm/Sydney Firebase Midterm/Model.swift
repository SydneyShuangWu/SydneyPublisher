//
//  Model.swift
//  Sydney Firebase Midterm
//
//  Created by Jovan ho on 2020/11/20.
//

import Foundation

struct Article: Codable {
  var author: Author
  var title: String
  var content: String
  var category: String
  var createdTime: Double
  var id: String
}

struct Author: Codable {
  var email: String
  var id: String
  var name: String
}
