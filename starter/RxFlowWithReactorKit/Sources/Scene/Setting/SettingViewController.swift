//
//  SettingViewController.swift
//  RxFlowWithReactorKit
//
//  Created by Myeongsoo Park on 2022/02/14.
//

import UIKit
import ReactorKit
import RxCocoa

final class SettingViewController: UIViewController {
	var disposeBag: DisposeBag = .init()
	
	typealias Reactor = SettingReactor
	
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

private extension SettingViewController {
	func setUI() {
		self.title = "Middle"
		view.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
	}
}

extension SettingViewController: View {
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
