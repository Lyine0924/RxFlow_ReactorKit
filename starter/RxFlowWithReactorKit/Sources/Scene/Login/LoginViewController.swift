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
	
	// MARK: UI Properties
	
	private let loginButton: UIButton = UIButton().then {
		$0.setTitle("login", for: .normal)
		$0.backgroundColor = .black
	}
	
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

private extension LoginVC {
	func setUI() {
		self.title = "Login"
		view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
		
		view.addSubview(loginButton)
		
		loginButton.snp.makeConstraints {
			$0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(50)
			$0.height.equalTo(50)
		}
	}
}

extension LoginVC {
	func bind(reactor: Reactor) {
		bindView(reactor)
		bindAction(reactor)
		bindState(reactor)
	}
	
	private func bindView(_ reactor: Reactor) {
		loginButton.rx.tap
			.map { Reactor.Action.loginButtonDidTap }
			.bind(to: reactor.action)
			.disposed(by: disposeBag)
	}
	
	private func bindAction(_ reactor: Reactor) {}
	
	private func bindState(_ reactor: Reactor) {}
}
