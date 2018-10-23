//
//  SecondTutorialController.swift
//  EasyVent
//
//  Created by Thomas on 8/28/17.
//  Copyright © 2017 DreamSoftware. All rights reserved.
//

import UIKit
import SDWebImage
class SecondTutorialController: UIViewController {

    var parentView = TutorialVC()
    var chatData:[NSDictionary] = []
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        
        self.tableview.estimatedRowHeight = 50
        self.tableview.rowHeight = UITableViewAutomaticDimension
        tableview.dataSource = self
        tableview.reloadData()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

//    @IBAction func onClick_start(_ sender: UIButton) {
//        parentView.goToNextPage(animated: true)
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SecondTutorialController:UITableViewDataSource,UITableViewDelegate{
    //MARK: Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatData.count
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.isDragging {
            cell.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 0.3, animations: {
                cell.transform = CGAffineTransform.identity
            })
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let obj = self.chatData[indexPath.row]
        if indexPath.row % 2 != 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ToCellForChat", for: indexPath) as! ToCellForChat
            
            if let msg = obj.value(forKey: "text")
            {
                cell.lblmsg.text = "\(msg)"
                //cell.lblmsg.text = "tableView.dequeueReusableCell(withIdentifier: ToCellForChat, for: indexPath) as! ToCellForChat"
                
            }
            cell.CsMsgWidth.constant = tableView.frame.width * 0.65
                 
            if let img = obj.value(forKey: "image")
            {
                cell.userimg.sd_setImage(with: URL(string: "\(img)"), completed: nil)
            }
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FromCellForChat", for: indexPath) as! FromCellForChat
            
            if let msg = obj.value(forKey: "text")
            {
                cell.lblmsg.text = "\(msg)"
                //cell.lblmsg.text = "tableView.dequeueReusableCell(withIdentifier: ToCellForChat, for: indexPath) as! ToCellForChat"
                
            }
            
            if let img = obj.value(forKey: "image")
            {
                cell.userimg.sd_setImage(with: URL(string: "\(img)"), completed: nil)
            }
            cell.CsMsgWidth.constant = tableView.frame.width * 0.65
            return cell
        }
    }
    
}




class ToCellForChat: UITableViewCell {
    
    @IBOutlet weak var userimg: UIImageView!
    @IBOutlet weak var lblmsg: UILabel!
    @IBOutlet weak var CsMsgWidth: NSLayoutConstraint!
    
}

class FromCellForChat: UITableViewCell {
    
    @IBOutlet weak var userimg: UIImageView!
    @IBOutlet weak var lblmsg: UILabel!
    
    @IBOutlet weak var CsMsgWidth: NSLayoutConstraint!
    
}









