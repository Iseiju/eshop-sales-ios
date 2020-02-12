//
//  GameCell.swift
//  nodeAPI
//
//  Created by Kenneth James Uy on 02/08/2019.
//  Copyright © 2019 Kenneth James Uy. All rights reserved.
//

import Alamofire
import AlamofireImage
import MaterialComponents
import UIKit

class GameCell: UITableViewCell {
  
  var cellViewModel: GameCellViewModel? = nil
  
  var title: String? = nil
  var price: Double? = nil
  var salePrice: Double? = nil
  
  let placeholder = UIImage(named: "ic-placeholder")
  var inkTouchController: MDCInkTouchController!
  
  static var cellIdentifier = String(describing: GameCell.self)

  @IBOutlet weak var gameView: UIView!

  @IBOutlet weak var boxArtImageView: UIImageView!

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var salePriceLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    
    initViews()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  private func initViews() {
    self.selectionStyle = .none
    self.boxArtImageView.tintColor = .orange
    inkTouchController = MDCInkTouchController(view: self.gameView)
    inkTouchController.addInkView()
  }
  
  func initCell(cellViewModel: GameCellViewModel) {
    self.cellViewModel = cellViewModel
    
    self.titleLabel.text = self.cellViewModel?.title
    
    guard let url = URL(string: self.cellViewModel?.boxArt ?? "") else { return }
    self.boxArtImageView.af_setImage(withURL: url,
                                     placeholderImage: placeholder,
                                     imageTransition: .crossDissolve(0.2))
    
    self.priceLabel.attributedText = "$\(cellViewModel.price)".strikeOutText()
    self.salePriceLabel.text = "$\(self.cellViewModel?.salePrice ?? 0.0)"
    self.salePriceLabel.textColor = .orange
  }
}
