//
//  AddViewController.swift
//
//  Created by fumiyatanaka_admin on 2020/11/23.
//

import UIKit

class AddViewController: UIViewController {

    // イベントの名前を入力するTextField
    @IBOutlet var eventNameTextField: UITextField!
    // 時間を入力するTextField
    @IBOutlet var hourTextField: UITextField!
    // 分を入力するTextField
    @IBOutlet var minuteTextField: UITextField!
    // 秒を入力するTextField
    @IBOutlet var secondTextField: UITextField!
    // セットボタン
    @IBOutlet var setButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventNameTextField.delegate = self
        setButton.layer.cornerRadius = 16
        setButton.layer.masksToBounds = true
        setButton.layer.borderWidth = 2
        setButton.layer.borderColor = setButton.tintColor.cgColor
        setButton.titleLabel?.adjustsFontForContentSizeCategory = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let dictionary = UserDefaults.standard.dictionary(forKey: "event")
        // nilかどうかをif文で確認している
        if dictionary != nil {
            let name = dictionary!["name"] as! String
            let totalDuration = dictionary!["totalDuration"] as! Double
            let alert = UIAlertController(title: name, message: "合計時刻: \(totalDuration)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "閉じる", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func tapSetButton() {
        let name = eventNameTextField.text!
        if name.isEmpty {
            let alert = UIAlertController(title: "エラー", message: "イベント名が入力されていません", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "閉じる", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        var totalDuration: Double = 0
        if hourTextField.text?.isEmpty == false {
            totalDuration += Double(hourTextField.text!)! * 3600
        }
        if minuteTextField.text?.isEmpty == false {
            totalDuration += Double(minuteTextField.text!)! * 60
        }
        if secondTextField.text?.isEmpty == false {
            totalDuration += Double(secondTextField.text!)!
        }
        let now = Date()
        let dictionary: [String: Any] = [
            "name": name,
            "totalDuration": totalDuration,
            "createTime": now.timeIntervalSince1970
        ]
        // 保存
        UserDefaults.standard.setValue(dictionary, forKey: "event")
        // 前の画面に戻る
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapScreen() {
        // キーボードを閉じる
        view.endEditing(true)
    }
}

extension AddViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
