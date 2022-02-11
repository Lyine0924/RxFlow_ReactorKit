//
//  LoginViewController.swift
//  RxFlowWithReactorKit
//
//  Created by Myeongsoo Park on 2022/02/11.
//

import UIKit
import RxFlow
import RxCocoa
import ReactorKit
import Then

final class LoginVC: UIViewController, View {

	typealias Reactor = LoginReactor
	
	var disposeBag: DisposeBag = .init()
	
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
	
	func bind(reactor: Reactor) {
		
	}
}

private extension LoginVC {
	func setUI() {
		
	}
}
