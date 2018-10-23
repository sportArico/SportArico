

import UIKit
import XLPagerTabStrip

class LocationDetailVC: ButtonBarPagerTabStripViewController {

    
    
    @IBOutlet weak var lblHeading: UILabel!
    
    var isReload = false
    var CourtId = ""
    var Name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lblHeading.text = Name
        
        self.view.gestureRecognizers?.removeAll(keepingCapacity: false)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let tabBarVC = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as? TabBarVC else {
                    return
        }
        tabBarVC.view.gestureRecognizers?.removeAll()
        buttonBarView.selectedBar.backgroundColor = UIColor.colorFromHex(hexString: "#007AFF")
        self.settings.style.buttonBarItemTitleColor = UIColor.black
        self.settings.style.buttonBarItemFont = UIFont.systemFont(ofSize: 15)
        settings.style.buttonBarBackgroundColor = UIColor.white
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.selectedBarBackgroundColor = UIColor.colorFromHex(hexString: "#007AFF")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnShare(_ sender: Any) {
        let message = "Try this app to "
        //if let link = NSURL(string: "https://itunes.apple.com/us/app/easyvent/id1401839200?ls=1&mt=8") {
        let objectsToShare = [message] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
        //navigationController?.present(activityVC, animated: true, completion: nil)
        // }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: - PagerTabStripDataSource
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OverViewVC") as! OverViewVC
        child_1.Court_Id = self.CourtId
        let child_2 =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReviewVC") as! ReviewVC
        child_2.Court_ID = self.CourtId
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
