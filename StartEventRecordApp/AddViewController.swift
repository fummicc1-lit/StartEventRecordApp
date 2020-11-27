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
        // UITextFieldDelegateを指定（Returnキーを押した際の処理を実装するため）
        eventNameTextField.delegate = self
        // setButtonの角丸の大きさを指定
        setButton.layer.cornerRadius = 16
        // setButtonの枠線の太さを指定
        setButton.layer.borderWidth = 2
        // setButtonの枠線の色を指定
        //(setButton.tintColorはボタンの文字の色と同じなので、下のコードで枠線と文字の色を同じにすることができる)
        setButton.layer.borderColor = setButton.tintColor.cgColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // UserDefautlsから`key`に対応する保存したデータを取り出す
        let dictionary: [String: Any]? = UserDefaults.standard.dictionary(forKey: "event")
        // nilかどうかをif文で確認している
        if dictionary != nil {
            // dictionaryの中のデータを一つずつ取り出していく
            
            
            // dictionaryの中にある`name`というkeyをString型で取り出す
            let name = dictionary!["name"] as! String
            // dictionaryの中にある`totalDuration`というkeyをDouble型で取り出す
            let totalDuration = dictionary!["totalDuration"] as! Double
            // アラートに表示する
            let alert = UIAlertController(title: name, message: "合計時刻: \(totalDuration)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "閉じる", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    // セットボタンと関連付けする（TouchUpInside）
    @IBAction func tapSetButton() {
        // 入力したテキストを取得する
        // (取り出したデータは意味的に名前なのでnameという変数を作成)
        let name = eventNameTextField.text!
        // nameが空（""のこと）かどうかをif文で確認する
        if name.isEmpty {
            // 名前が入力されていないので、アラートを表示する
            let alert = UIAlertController(title: "エラー", message: "イベント名が入力されていません", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "閉じる", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            // returnと書くこのメソッドの以降の処理を実行しないで終了できる
            return
        }
        // 合計時間を秒で変換して保存する
        // (1時間は3600秒)
        //（1分は60秒）
        var totalDuration: Double = 0
        
        // 入力したテキストが空でない場合は、それを数字に変換して秒変換をした後に`totalDuration`に代入する
        
        // hourTextField（時間入力）に関して
        if hourTextField.text?.isEmpty == false {
            totalDuration += Double(hourTextField.text!)! * 3600
        }
        
        // minuteTextField（分入力）に関して
        if minuteTextField.text?.isEmpty == false {
            totalDuration += Double(minuteTextField.text!)! * 60
        }
        
        // secondTextField（秒入力）に関して
        if secondTextField.text?.isEmpty == false {
            totalDuration += Double(secondTextField.text!)!
        }
        // 現在時刻を`now`という変数に代入する
        let now: Date = Date() // Date() ... 現在時刻を作成できる
        // 保存したいデータをまとめて一つのdictionary型に格納する
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
