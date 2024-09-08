//
//  TestViewController.swift
//  
//
//  Created by Sara Galal on 08/09/2024.
//

import UIKit

public class TestViewController: UIViewController {

   public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // Initialize the view controller using the storyboard
        public static func instantiateFromStoryboard() -> TestViewController {
            let storyboard = UIStoryboard(name: "StoryBoard", bundle: Bundle.module)
            let viewController = storyboard.instantiateViewController(withIdentifier: "testView") as! TestViewController
            return viewController
        }
}
