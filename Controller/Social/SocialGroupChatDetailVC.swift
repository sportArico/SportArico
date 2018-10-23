

import UIKit
import KYDrawerController
import XLPagerTabStrip

class SocialGroupChatDetailVC: ButtonBarPagerTabStripViewController {
    
    //MARK: Outlet
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    //=== End ===//
    
    //MARK: Variable
    var isReload = false
    var ArraySocialGroupChat:[SocialGroupChatData] = []
    var group_id = ""
    var DetailData:SocialGroupDetailData?
    //=== End ===//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.SetUIDetail(data: DetailData)
        buttonBarView.selectedBar.backgroundColor = UIColor.colorFromHex(hexString: "#007AFF")
        self.settings.style.buttonBarItemTitleColor = UIColor.colorFromHex(hexString: "#0098C8")
        self.settings.style.buttonBarItemFont = UIFont.systemFont(ofSize: 15)
        self.settings.style.buttonBarHeight = 2.5
        settings.style.buttonBarBackgroundColor = UIColor.colorFromHex(hexString: "#F4F4F4")
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.selectedBarBackgroundColor = UIColor.colorFromHex(hexString: "#007AFF")
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnMenu(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func btnFillter(_ sender: Any) {
        
    }
    @IBAction func btnModifyBooking(_ sender: Any) {
        let storybord = UIStoryboard(name: "Social", bundle: nil)
        let VC = storybord.instantiateViewController(withIdentifier: "ModifyBookingVC") as! ModifyBookingVC
        navigationController?.pushViewController(VC, animated: true)
    }
   
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func SetUIDetail(data: SocialGroupDetailData?) {
        lblName.text = "Venue: \(data?.venue ?? "")"
        //lblLocation.text = data?.location
        lblDate.text = GetFormatedDate(From: "yyyy-MM-dd", To: "EEE,dd MMM", Value: (data?.eventDate)!)
        lblTime.text = data?.eventTime
    }
    
    
    // MARK: - PagerTabStripDataSource
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = UIStoryboard(name: "Social", bundle: nil).instantiateViewController(withIdentifier: "SocialGroupChatVC") as! SocialGroupChatVC
        child_1.group_id = self.group_id
        let child_2 =  UIStoryboard(name: "Social", bundle: nil).instantiateViewController(withIdentifier: "SocialUserListChatVC") as! SocialUserListChatVC
        child_2.group_id = self.group_id
        guard isReload else {
            return [child_1,
                    child_2]
        }
        
        var childViewControllers = [child_1,
                                    child_2]
        
        for index in childViewControllers.indices {
            let nElements = childViewControllers.count - index
            let n = (Int(arc4random()) % nElements) + index
            if n != index {
                childViewControllers.swapAt(index, n)
            }
        }
        let nItems = 1 + (arc4random() % 8)
        return Array(childViewControllers.prefix(Int(nItems)))
    }
    
    override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int, withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool)
    {
        
        
        buttonBarView.move(fromIndex: fromIndex, toIndex: toIndex, progressPercentage: progressPercentage, pagerScroll: .yes)
        if let changeCurrentIndexProgressive = changeCurrentIndexProgressive {
            let oldCell = buttonBarView.cellForItem(at: IndexPath(item: currentIndex != fromIndex ? fromIndex : toIndex, section: 0)) as? ButtonBarViewCell
            let newCell = buttonBarView.cellForItem(at: IndexPath(item: currentIndex, section: 0)) as? ButtonBarViewCell
            changeCurrentIndexProgressive(oldCell, newCell, progressPercentage, indexWasChanged, true)
        }
        
        if  ( toIndex  < viewController.viewControllers.count  && toIndex >= 0 )
        {
            let newIndexPath = NSIndexPath(row: toIndex, section: 0)
            buttonBarView.selectItem(at: newIndexPath as IndexPath, animated: true, scrollPosition:UICollectionViewScrollPosition.centeredHorizontally)
        }
        
        
    }
    
    override func reloadPagerTabStripView() {
        isReload = true
        if arc4random() % 2 == 0 {
            pagerBehaviour = .progressive(skipIntermediateViewControllers: arc4random() % 2 == 0, elasticIndicatorLimit: arc4random() % 2 == 0 )
        } else {
            pagerBehaviour = .common(skipIntermediateViewControllers: arc4random() % 2 == 0)
        }
        super.reloadPagerTabStripView()
    }
    
}


