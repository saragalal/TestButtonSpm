//
//  SimpleViewController.swift
//
//
//  Created by Sara Galal on 08/09/2024.
//

import UIKit

class SimpleViewController: UIViewController {
    
    @IBOutlet private var tapButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
      }
    // Load the view from the .xib file
        public init() {
            super.init(nibName: "SimpleViewController", bundle: Bundle.module)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    private func setupButton() {
        tapButton.setTitle("Tap Me", for: .normal)
        tapButton.backgroundColor = .purple
        tapButton.layer.cornerRadius = 10
        tapButton.setTitleColor(.white, for: .normal)
    }
    public func changeButtonColor(to color: UIColor) {
        tapButton.backgroundColor = color
    }
    public func changeButtonText(to text: String) {
        tapButton.setTitle("Tap Me", for: .normal)
    }
}
