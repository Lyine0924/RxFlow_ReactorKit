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

final class HomeViewController: UIViewController, View {
	
	typealias Reactor = HomeReactor
	
	var disposeBag: DisposeBag = .init()
	
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
	}
}

extension HomeViewController {
	func bind(reactor: Reactor) {
		
	}
}
