

import UIKit
import KYDrawerController

class ChatVC: UIViewController {
    
    
    @IBOutlet weak var tblChatView: UITableView!
    @IBOutlet weak var txtmessage: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    
    
    var chatdata:[ChatStruct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customization()
        
        chatdata.append(ChatStruct(message: "Hey john, Would you like to go the coffee tonight?", type:"text", id: "1", imageDp: "photo.png"))
        chatdata.append(ChatStruct(message: "Oh sure! \n When do you want to go?", type:"text", id: "2", imageDp: "photo.png"))
        chatdata.append(ChatStruct(message: "is 7:00 PM all right?", type:"text", id: "1", imageDp: "photo.png"))
        chatdata.append(ChatStruct(message: "Yes, thet's good. See you tonight.", type:"text", id: "2", imageDp: "photo.png"))
        
        tblChatView.delegate = self
        tblChatView.dataSource = self
        tblChatView.reloadData()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnMenu(_ sender: Any) {
        if let drawerController = navigationController?.parent as? KYDrawerController {
            drawerController.setDrawerState(.opened, animated: true)
        }
    }
    @IBAction func btnFillter(_ sender: Any) {
        
    }
    @IBAction func btnModifyBooking(_ sender: Any) {
        let storybord = UIStoryboard(name: "Social", bundle: nil)
        let VC = storybord.instantiateViewController(withIdentifier: "ModifyBookingVC") as! ModifyBookingVC
        navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func btnSend(_ sender: Any) {
        if !(txtmessage.text?.isEmpty)!{
            chatdata.append(ChatStruct(message: txtmessage.text!, type:"text", id: "2", imageDp: "photo.png"))
            txtmessage.text = ""
        }
        tblChatView.delegate = self
        tblChatView.dataSource = self
        tblChatView.reloadData()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK: - Customization
    func customization() {
        self.tblChatView.estimatedRowHeight = 50
        self.tblChatView.rowHeight = UITableViewAutomaticDimension
        //self.tableView.contentInset.bottom = 50
        //self.tableView.scrollIndicatorInsets.bottom = 50
    }

}
extension ChatVC:UITableViewDataSource,UITableViewDelegate{
    //MARK: Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatdata.count
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
        let obj = self.chatdata[indexPath.row]
        if obj.id == "1"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Sender", for: indexPath) as! SenderCell
            cell.clearCellData()
            cell.message.text = obj.message
            cell.profilePic.image = UIImage(named: obj.imageDp)
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Receiver", for: indexPath) as! ReceiverCell
            cell.clearCellData()
            cell.message.text = obj.message
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
