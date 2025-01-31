//
//  HomeViewController.swift
//  RxFlowWithReactorKit
//
//  Created by Myeongsoo Park on 2022/02/11.
//

import UIKit

import RxFlow
import RxCocoa
import ReactorKit
import Then

final class HomeViewController: UIViewController, View {
	
	typealias Reactor = HomeReactor
	
	var disposeBag: DisposeBag = .init()
	
	private let tableView = UITableView().then {
		$0.register(HomeCell.self, forCellReuseIdentifier: HomeCell.reusableID)
		$0.rowHeight = 50
		$0.separatorStyle = .none
	}
	
	init(with reactor: HomeReactor) {
		super.init(nibName: nil, bundle: nil)
		
		self.reactor = reactor
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	deinit {
		print("\(type(of: self)): \(#function)")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setUI()
	}
}

private extension HomeViewController {
	func setUI() {
		self.title = "Home"
		view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
		
		view.addSubview(tableView)
		tableView.snp.makeConstraints {
			$0.edges.equalTo(view.safeArea.edges)
		}
	}
}

extension HomeViewController {
	func bind(reactor: Reactor) {
		bindView(reactor)
		bindAction(reactor)
		bindState(reactor)
	}
	
	private func bindView(_ reactor: Reactor) {
		tableView.rx.modelSelected(Movie.self)
			.map { $0.description }
			.map { Reactor.Action.itemSelected(title: $0) }
			.bind(to: reactor.action)
			.disposed(by: disposeBag)
	}
	
	private func bindAction(_ reactor: Reactor) {
		self.rx.viewWillAppear
			.map { _ in Reactor.Action.loadData }
			.bind(to: reactor.action)
			.disposed(by: disposeBag)
	}
	
	private func bindState(_ reactor: Reactor) {
		let sharedState = reactor.state.share(replay: 1).subscribe(on: MainScheduler.instance)
		
		sharedState
			.compactMap { $0.movies }
			.bind(to:
							tableView.rx.items(
								cellIdentifier: HomeCell.reusableID,
								cellType: HomeCell.self
							)
			) { index, item, cell in
				cell.bind(with: item)
			}
			.disposed(by: disposeBag)
	}
}
