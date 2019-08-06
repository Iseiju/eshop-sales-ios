//
//  LandingController.swift
//  nodeAPI
//
//  Created by Kenneth James Uy on 05/08/2019.
//  Copyright © 2019 Kenneth James Uy. All rights reserved.
//

import UIKit

class LandingController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    toMainCoordinator()
  }
  
  private func toMainCoordinator() {
    let mainCoordinator = MainCoordinator(presentingViewController: self)
    mainCoordinator.presentMain()
  }
}
