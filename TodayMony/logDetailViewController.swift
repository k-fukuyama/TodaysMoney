//
//  logDetailViewController.swift
//  TodayMony
//
//  Created by Keita Fukuyama on 2018/09/29.
//  Copyright © 2018年 Keita Fukuyama. All rights reserved.
//

import UIKit

class logDetailViewController: UIViewController, UITabBarDelegate, UITableViewDataSource{
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      print(keyBox)
      print(valueBox)
    }
  
  var valueBox: [Int] = []
  var keyBox: [String] = []
  var vc = ViewController()
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    
    return valueBox.count
    
  }
  
  var saveString = ""
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = logTable.dequeueReusableCell(withIdentifier: "logDetailCell") as! logDetailTableViewCell
    cell.logTextfield.text! = String(valueBox[indexPath.row])
    
    
    //    cell?.textLabel!.text! = String(valueBox[indexPath.row])
    
    return cell
  }
  
    
  @IBOutlet weak var logTable: UITableView!
  
  @IBAction func backButton(_ sender: Any) {
    
    self.dismiss(animated: true, completion: {
      usedMoneyLogController().valueBox.removeAll()
      usedMoneyLogController().update()
    })
  }
  
  func textFieldDidEndEditing(cell: logDetailTableViewCell, value: String) {
    
    let index = logTable.indexPathForRow(at: cell.convert(cell.bounds.origin, to:logTable))
    print("変更されたインデックス\(value)")
    saveString = value
  }
  
  var editedDoneAlert = UIAlertController(title: nil,
                                         message: "編集が完了しました",
                                         preferredStyle: .alert)
  
  
  
  @IBAction func saveButton(_ sender: Any) {
    
    let editedNum = Int(editedLog)!
    var result = 0
    let dvc = detailmonyViewController()
    var dvcSetNum = 0
    var todayRemainTextNum = 0
    
    var vcHash = vc.hashLog.dictionary(forKey: "hash")
    vcHash![keyBox[0]] = editedNum
    vc.hashLog.set(vcHash, forKey: "hash")
    
    editedDoneAlert.addAction(UIAlertAction(title: "OK", style: .default){ action in
      self.dismiss(animated: true, completion: {
        usedMoneyLogController().valueBox.removeAll()
        usedMoneyLogController().update()
      })
    })
    
    
    if editedNum > valueBox[0]{
      result = editedNum - valueBox[0]
      dvcSetNum = dvc.SaveOneMonthMoneyResult.integer(forKey: "SaveMoney") - result
      dvc.SaveOneMonthMoneyResult.set(dvcSetNum, forKey: "SaveMoney")
      
      todayRemainTextNum = vc.ud.integer(forKey: "mony") - result
      vc.ud.set(todayRemainTextNum, forKey: "mony")
      
      self.present(editedDoneAlert, animated: true, completion: nil)
      print("大きい方でした")
      
    }else{
      result = valueBox[0] - editedNum
      dvcSetNum = dvc.SaveOneMonthMoneyResult.integer(forKey: "SaveMoney") + result
      dvc.SaveOneMonthMoneyResult.set(dvcSetNum, forKey: "SaveMoney")
      
      todayRemainTextNum = vc.ud.integer(forKey: "mony") + result
      vc.ud.set(todayRemainTextNum, forKey: "mony")
      
      self.present(editedDoneAlert, animated: true, completion: nil)
      print("小さい方でした")
    }
    
    
    
  }
  
  func adjustment(num: Int, editedValu: Int){
    print(vc.ud.integer(forKey: "mony"))
    var beforeNum = vc.ud.integer(forKey: "mony") + num
    print("これがbefore\(beforeNum)")
    var trueNum = float_t(editedValu) / float_t(beforeNum) * 100
    
    vc.ud3.set(CGFloat(trueNum), forKey: "resultmonyyy")
  }
  
  
  
 
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
