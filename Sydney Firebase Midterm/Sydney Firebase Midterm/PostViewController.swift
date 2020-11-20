//
//  PostViewController.swift
//  Sydney Firebase Midterm
//
//  Created by Jovan ho on 2020/11/20.
//

import UIKit
import FirebaseFirestore

var sendTextClosure: ((String, String, String) -> ())?

class PostViewController: UIViewController {
  
  var pickerData: [String] = [String]()
  
  @IBOutlet weak var inputTitleTF: UITextField!
  @IBOutlet weak var inputCategoryTF: UITextField!
  @IBOutlet weak var inputContentTF: UITextField! {
    didSet {
      let categoryPicker = UIPickerView()
      categoryPicker.delegate = self
      categoryPicker.dataSource = self
      inputCategoryTF.inputView = categoryPicker
    }
  }
  @IBOutlet weak var publishButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    pickerData = ["Beauty", "SchoolLife", "Others"]
//    publishButton.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
  }
  
  @IBAction func addData(_ sender: Any) {
    guard let titleText = inputTitleTF.text, let contentText = inputContentTF.text, let categoryText = inputCategoryTF.text else {
      return
    }
    
    let articles = Firestore.firestore().collection("articles")
      
    let document = articles.document()
      
    let data: [String : Any] = [
      "title" : titleText,
      "content" : contentText,
      "createdTime" : FirebaseFirestore.FieldValue.serverTimestamp(),
      "id" : document.documentID,
      "category" : categoryText,
      "author" : "Sydney"
    ]
      
    document.setData(data)
    
    navigationController?.popViewController(animated: true)
  }
  
  
//  @objc func handleButtonTap(sender: UIButton) {
//
//    guard let titleText = inputTitleTF.text, let contentText = inputContentTF.text, let categoryText = inputCategoryTF.text else {
//      return
//    }
//
//    sendTextClosure!(titleText, contentText, categoryText)
//
//    addArticle()
//
//    navigationController?.popViewController(animated: true)
//  }
  


}

extension PostViewController: UIPickerViewDelegate, UIPickerViewDataSource {
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickerData.count
  }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return pickerData[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    inputCategoryTF.text = pickerData[row]
  }
}
