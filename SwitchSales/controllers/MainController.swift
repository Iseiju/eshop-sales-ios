//
//  MainController.swift
//  nodeAPI
//
//  Created by Kenneth James Uy on 14/06/2019.
//  Copyright © 2019 Kenneth James Uy. All rights reserved.
//

import Alamofire
import StatefulTableView
import RxCocoa
import RxSwift
import UIKit

protocol MainControllerDelegate {
  
  func didTapGame(forIndexPath indexPath: IndexPath, controller: MainController)
}

class MainController: UIViewController {
  
  let disposeBag = DisposeBag()
  
  var viewModel: GameViewModel? = nil
  
  var delegate: MainControllerDelegate? = nil
  
  var isSearchBarHidden: Bool = true
  
  var searchBarHeight: CGFloat? = nil
  
  var searchBarHeightConstraint: NSLayoutConstraint? = nil
  
  @IBOutlet weak var searchBarView: UIView!
  
  @IBOutlet weak var searchTextField: UITextField!
  
  @IBOutlet weak var tableView: StatefulTableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initViews()
    registerNib()
    initObservables()
  }
  
  private func initViews() {
    searchBarHeight = searchBarView.bounds.size.height
    searchBarHeightConstraint = searchBarView.height(0)

    var textAttribute: [NSAttributedString.Key : Optional<NSObject>] = [:]
    
    switch UIDevice.current.userInterfaceIdiom {
    case .phone:
      textAttribute = [NSAttributedString.Key.foregroundColor: UIColor.orange,
                           NSAttributedString.Key.font: UIFont(name: "GoogleSans-Bold", size: 16)]
    case .pad:
      textAttribute = [NSAttributedString.Key.foregroundColor: UIColor.orange,
                           NSAttributedString.Key.font: UIFont(name: "GoogleSans-Bold", size: 19)]
    case .unspecified:
      return
    case .tv:
      return
    case .carPlay:
      return
    @unknown default:
      return
    }

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
    tableView.canLoadMore = false
    tableView.canPullToRefresh = true
    tableView.statefulDelegate = self

    tableView.triggerInitialLoad()
  }
  
  private func initObservables() {
    viewModel?
      .cellViewModels()
      .bind(to: tableView.innerTable.rx.items(cellIdentifier: GameCell.cellIdentifier,
                                              cellType: GameCell.self)) { index, cellViewModel, cell in
                                                cell.initCell(cellViewModel: cellViewModel)
    }.disposed(by: disposeBag)
    
    tableView
      .innerTable
      .rx
      .itemSelected
      .subscribe(onNext: { index in
        self.delegate?.didTapGame(forIndexPath: index, controller: self)
    }).disposed(by: disposeBag)
    
    searchTextField
      .rx
      .text
      .asObservable()
      .subscribe(onNext: { text in
        guard let query = text else { return }
        self.viewModel?.search(forQuery: query)
    }).disposed(by: disposeBag)
  }
  
  @IBAction func didTapSearch(_ sender: Any) {
    guard let searchBarHeight = self.searchBarHeight else { return }
    
    switch isSearchBarHidden {
    case true:
      UIView.animate(withDuration: 0.3) { [weak self] in
        self?.searchBarHeightConstraint?.constant = searchBarHeight
        self?.isSearchBarHidden = false
        self?.view.layoutIfNeeded()
      }
    case false:
      UIView.animate(withDuration: 0.3) { [weak self] in
        self?.searchBarHeightConstraint?.constant = 0
        self?.isSearchBarHidden = true
        self?.searchTextField.text = nil
        self?.view.layoutIfNeeded()
        self?.view.endEditing(true)
      }
    }
  }
}

extension MainController: StatefulTableDelegate {
  
  func statefulTable(_ tableView: StatefulTableView,
                     initialLoadCompletion completion: @escaping InitialLoadCompletion) {
    statefulTable(tableView, pullToRefreshCompletion: completion)
  }
  
  func statefulTable(_ tableView: StatefulTableView,
                     pullToRefreshCompletion completion: @escaping InitialLoadCompletion) {
    self.viewModel?.getGamesOnSale(onCompletion: completion)
  }
  
  func statefulTable(_ tableView: StatefulTableView,
                     loadMoreCompletion completion: @escaping LoadMoreCompletion) {
    completion(false, nil, false)
  }
  
  func statefulTable(_ tableView: StatefulTableView,
                     initialLoadWithError errorOrNil: NSError?,
                     errorView: InitialLoadErrorView) -> UIView? {
    errorView.labelText = "Something went wrong"
    errorView.shouldShowRetryButton = true
    return errorView
  }
}

extension MainController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}

extension MainController: StoryboardInstantiable {
  
  static var storyboardName: String {
    return "Main"
  }
}
