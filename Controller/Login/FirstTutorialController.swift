//
//  FirstTutorialController.swift
//  EasyVent
//
//  Created by Thomas on 8/28/17.
//  Copyright © 2017 DreamSoftware. All rights reserved.
//

import UIKit

class FirestTutorialController: UIViewController{

    var parentView = TutorialVC()
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var lblText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    @IBAction func onClick_agree(_ sender: UIButton) {
        parentView.goToNextPage(animated: true)
    }
    @IBAction func onClick_disagree(_ sender: UIButton) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

