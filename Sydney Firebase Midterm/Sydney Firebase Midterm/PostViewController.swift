//
//  PostViewController.swift
//  Sydney Firebase Midterm
//
//  Created by Jovan ho on 2020/11/20.
//

import UIKit

class PostViewController: UIViewController {
  
  var pickerData: [String] = [String]()
  let manager = ModelManager()
  
  let author = Author(email: "sydney@gmail.com", id: "sydney87", name: "Sydney")
  
  @IBOutlet weak var publishButton: UIButton!
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    pickerData = ["Beauty", "SchoolLife", "Others"]
    publishButton.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
  }
  
  @objc func handleButtonTap(sender: UIButton) {
    
    guard let titleText = inputTitleTF.text, let contentText = inputContentTF.text, let categoryText = inputCategoryTF.text else { return }
    
    let article = Article(author: author, title: titleText, content: contentText, category: categoryText, createdTime: 0, id: "")
    
    manager.addArticle(article: article)
    
    navigationController?.popViewController(animated: true)
  }


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
