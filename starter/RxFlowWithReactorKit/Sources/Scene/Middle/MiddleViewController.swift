//
//  MiddleViewController.swift
//  RxFlowWithReactorKit
//
//  Created by Myeongsoo Park on 2022/02/14.
//

import UIKit
import ReactorKit
import RxCocoa

final class MiddleViewController: UIViewController {
	var disposeBag: DisposeBag = .init()
	
	typealias Reactor = MiddleReactor
	
	init(with reactor: Reactor) {
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

// MARK: - Extensions

private extension MiddleViewController {
	func setUI() {
		self.title = "Middle"
		view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
	}
}

extension MiddleViewController: View {
	func bind(reactor: Reactor) {
		bindView(reactor)
		bindAction(reactor)
		bindState(reactor)
	}
	
	private func bindView(_ reactor: Reactor) {
		
	}
	
	private func bindAction(_ reactor: Reactor) {
		
	}
	
	private func bindState(_ reactor: Reactor) {
		
	}
}
