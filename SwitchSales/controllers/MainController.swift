//
//  MainController.swift
//  nodeAPI
//
//  Created by Kenneth James Uy on 14/06/2019.
//  Copyright © 2019 Kenneth James Uy. All rights reserved.
//

import Alamofire
import StatefulTableView
import UIKit

protocol MainDelegate {
  
  func didTapGame(forIndexPath indexPath: IndexPath,
                  viewModel: GameViewModel,
                  navController: UINavigationController)
}

class MainController: UIViewController {
  
  var viewModel = GameViewModel()
  
  var delegate: MainDelegate? = nil

  @IBOutlet weak var tableView: StatefulTableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initViews()
    registerNib()
  }
  
  private func initViews() {
    let textAttribute = [NSAttributedString.Key.foregroundColor: UIColor.orange,
                         NSAttributedString.Key.font: UIFont(name: "GoogleSans-Bold", size: 16)]
    
    navigationController?.navigationBar.titleTextAttributes = textAttribute
      as [NSAttributedString.Key : Any]
    navigationController?.navigationBar.tintColor = .orange
    navigationController?.navigationBar.barTintColor = .white
  }
  
  private func registerNib() {
    let gameNibCell = UINib(nibName: GameCell.cellIdentifier, bundle: nil)
    tableView.innerTable.register(gameNibCell, forCellReuseIdentifier: GameCell.cellIdentifier)
    tableView.separatorStyle = .none

    tableView.delegate = self
    tableView.dataSource = self
    tableView.canLoadMore = false
    tableView.canPullToRefresh = true
    tableView.statefulDelegate = self

    tableView.triggerInitialLoad()
  }
}

extension MainController: StatefulTableDelegate {
  
  func statefulTable(_ tableView: StatefulTableView,
                     initialLoadCompletion completion: @escaping InitialLoadCompletion) {
    statefulTable(tableView, pullToRefreshCompletion: completion)
  }
  
  func statefulTable(_ tableView: StatefulTableView,
                     pullToRefreshCompletion completion: @escaping InitialLoadCompletion) {
    self.viewModel.getGamesOnSale(tableView: tableView, onCompletion: completion)
  }
  
  func statefulTable(_ tableView: StatefulTableView,
                     loadMoreCompletion completion: @escaping LoadMoreCompletion) {
    completion(false, nil, false)
  }
}

extension MainController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let navController = self.navigationController else { return }
    self.delegate?.didTapGame(forIndexPath: indexPath,
                              viewModel: viewModel,
                              navController: navController)
  }
}

extension MainController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.viewModel.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard indexPath.row < self.viewModel.count else { return UITableViewCell() }
    let cell = tableView.dequeueReusableCell(withIdentifier: GameCell.cellIdentifier,
                                             for: indexPath) as! GameCell
    
    let cellViewModel = self.viewModel.cellViewModels(forIndexPath: indexPath)
    
    cell.initCell(cellViewModel: cellViewModel)
    return cell
  }
}

extension MainController: StoryboardInstantiable {
  
  static var storyboardName: String {
    return "Main"
  }
}