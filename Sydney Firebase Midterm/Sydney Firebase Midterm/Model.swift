//
//  Model.swift
//  Sydney Firebase Midterm
//
//  Created by Jovan ho on 2020/11/20.
//

import Foundation
import Firebase
import FirebaseFirestore

var articles = [Article]()
var db = Firestore.firestore()

struct Article: Identifiable {
  var author: String
  var title: String
  var content: String
  var createdTime: Date
  var id: String
  var category: String
}

//struct AuthorData: Identifiable {
//  var email: String
//  var id: String
//  var name: String
//}

//func addArticle() {
//
//  var title = ""
//  var content = ""
//  var category = ""
//
//  sendTextClosure = { titleText, contentText, categoryText in
//    title = titleText
//    content = contentText
//    category = categoryText
//  }
//
//  let articles = Firestore.firestore().collection("articles")
//
//  let document = articles.document()
//
//  let data: [String : Any] = [
//      "title" : title,
//      "content" : content,
//      "createdTime" : FirebaseFirestore.FieldValue.serverTimestamp(),
//      "id" : document.documentID,
//      "category" : category
//  ]
//
//  document.setData(data)
//}
//
//
//func listenArticles() {
//
//  db.collection("articles")
//    .addSnapshotListener { (querySnapshot, error) in
//      guard let snapshot = querySnapshot else {
//        print("Error fetching snapshots: \(error!)")
//        return
//      }
//
//      snapshot.documentChanges.forEach { diff in
//        if (diff.type == .added) {
//          print("New article: \(diff.document.data())")
//          articles = querySnapshot!.documents
//        }
//        if diff.type == .modified {
//          print("Modified article: \(diff.document.data())")
//          articles = querySnapshot!.documents
//        }
//      }
//    }
//
//}
