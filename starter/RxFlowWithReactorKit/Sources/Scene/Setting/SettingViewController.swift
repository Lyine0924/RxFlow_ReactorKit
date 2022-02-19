//
//  SettingViewController.swift
//  RxFlowWithReactorKit
//
//  Created by Myeongsoo Park on 2022/02/14.
//

import UIKit
import ReactorKit
import RxCocoa
import Then

final class SettingViewController: UIViewController {
	var disposeBag: DisposeBag = .init()
	
	typealias Reactor = SettingReactor
	
	// MARK: UI Properties
	
	private let logoutButton: UIButton = UIButton().then {
		$0.setTitle("logout", for: .normal)
		$0.backgroundColor = .black
	}
	
	private let alertButton: UIButton = UIButton().then {
		$0.setTitle("showAlert", for: UIControl.State())
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

// MARK: - Extensions

private extension SettingViewController {
	func setUI() {
		self.title = "Setting"
		view.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
		
		[logoutButton, alertButton].forEach {
			self.view.addSubview($0)
		}
		
		logoutButton.snp.makeConstraints {
			$0.leading.trailing.equalToSuperview().inset(50)
			$0.bottom.equalTo(view.safeArea.bottom).inset(50)
			$0.height.equalTo(50)
		}
		
		alertButton.snp.makeConstraints {
			$0.leading.trailing.equalToSuperview().inset(50)
			$0.bottom.equalTo(logoutButton.snp.top).offset(-50)
			$0.height.equalTo(50)
		}
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
