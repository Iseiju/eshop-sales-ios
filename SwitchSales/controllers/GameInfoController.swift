//
//  GameInfoController.swift
//  nodeAPI
//
//  Created by Kenneth James Uy on 05/08/2019.
//  Copyright © 2019 Kenneth James Uy. All rights reserved.
//

import AlamofireImage
import MaterialComponents
import UIKit

protocol GameInfoDelegate {
  
  func toEshop(controller: GameInfoController, url: String)
}


class GameInfoController: UIViewController {

  var viewModel: GameInfoViewModel? = nil
  
  var delegate: GameInfoDelegate? = nil
  
  var inkTouchController: MDCInkTouchController!
  
  @IBOutlet weak var gameView: MDCCard!

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var salePriceLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var releaseDateLabel: UILabel!
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var companyLabel: UILabel!
  
  @IBOutlet weak var boxArtImageView: UIImageView!
  @IBOutlet weak var esrbImageView: UIImageView!
  
  @IBOutlet weak var toEshopButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    initViews()
  }
  
  private func initViews() {
    gameView.inkView.isHidden = true
    
    guard let url = URL(string: self.viewModel?.boxArt ?? "") else { return }
    boxArtImageView.af_setImage(withURL: url)
    
    if viewModel?.esrb == "Everyone" {
      esrbImageView.image = UIImage(named: "ic-everyone")
    } else if viewModel?.esrb == "Teen" {
      esrbImageView.image = UIImage(named: "ic-teen")
    } else if viewModel?.esrb == "Mature" {
      esrbImageView.image = UIImage(named: "ic-mature")
    } else if viewModel?.esrb == "Everyone 10+" {
      esrbImageView.image = UIImage(named: "ic-everyone10")
    } else if viewModel?.esrb == "Adults Only" {
      esrbImageView.image = UIImage(named: "ic-adultsonly")
    } else if viewModel?.esrb == "Early Childhood" {
      esrbImageView.image = UIImage(named: "ic-earlychildhood")
    } else {
      esrbImageView.image = UIImage(named: "ic-ratingpending")
    }
    
    titleLabel.text = viewModel?.title
    guard let price = viewModel?.price else { return }
    guard let salePrice = viewModel?.salePrice else { return }
    priceLabel.attributedText = "$\(price)".strikeOutText()
    salePriceLabel.textColor = .orange
    salePriceLabel.text = "$\(salePrice)"
    
    toEshopButton.layer.cornerRadius = 8.0
    inkTouchController = MDCInkTouchController(view: toEshopButton)
    inkTouchController.view?.layer.cornerRadius = 8.0
    inkTouchController.addInkView()
    
    descriptionLabel.text = viewModel?.description
    
    guard let releaseDate = viewModel?.releaseDate.components(separatedBy: "T")[0] else { return }
    let formattedDate = releaseDate.formatDate(fromFormat: "yyyy-mm-dd", toFormat: "MMM d, yyyy")
    guard let categories = viewModel?.categories else { return }
    guard let company = viewModel?.company else { return }
    
    releaseDateLabel.text = "Release Date: \(formattedDate)"
    categoryLabel.text = "Category: \(categories)"
    companyLabel.text = "Company: \(company)"
  }
  
  @IBAction func didTapShop(_ sender: Any) {
    delegate?.toEshop(controller: self, url: self.viewModel?.url ?? "")
  }
}

extension GameInfoController: StoryboardInstantiable {
  
  static var storyboardName: String {
    return "Main"
  }
}
