//
//  MiddleDetailViewController.swift
//  RxFlowWithReactorKit
//
//  Created by Lyine on 2022/02/27.
//

import UIKit

import RxCocoa
import ReactorKit

final class MiddleDetailViewContorller: UIViewController, View {
	
	typealias Reactor = MiddleDetailReactor
	
	// MARK: Property
	
	var disposeBag: DisposeBag = .init()
	
	// MARK: Initializers
	
	init(with reactor: Reactor) {
		super.init(nibName: nil, bundle: nil)
		
		self.reactor = reactor
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
		// MARK: LifeCycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setUI()
	}
}

// MARK: - Extension

extension MiddleDetailViewContorller {
	private func setUI() {
		view.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
	}
	
	func bind(reactor: Reactor) {
		
	}
}
