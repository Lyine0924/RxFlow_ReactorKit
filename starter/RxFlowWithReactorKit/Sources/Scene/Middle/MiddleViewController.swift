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
	
	// MARK: UI Properties
	
	private let detailButton: UIButton = UIButton().then {
		$0.setTitle("toMiddleDetail", for: .normal)
		$0.backgroundColor = .black
	}
	
	private let twoDepthFlow: UIButton = UIButton().then {
		$0.setTitle("twoDepthFlow", for: UIControl.State())
		$0.backgroundColor = .black
	}
	
	private let transitionButton: UIButton = UIButton().then {
		$0.setTitle("transitionButton", for: UIControl.State())
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

private extension MiddleViewController {
	func setUI() {
		self.title = "Middle"
		view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
		
		view.addSubview(detailButton)
		detailButton.snp.makeConstraints {
			$0.leading.trailing.equalToSuperview().inset(50)
			$0.bottom.equalTo(view.safeArea.bottom).inset(50)
			$0.height.equalTo(50)
		}
		
		view.addSubview(twoDepthFlow)
		twoDepthFlow.snp.makeConstraints {
			$0.leading.trailing.equalToSuperview().inset(50)
			$0.bottom.equalTo(detailButton.snp.top).offset(-50)
			$0.height.equalTo(50)
		}
		
		view.addSubview(transitionButton)
		transitionButton.snp.makeConstraints {
			$0.leading.trailing.equalToSuperview().inset(50)
			$0.bottom.equalTo(twoDepthFlow.snp.top).offset(-50)
			$0.height.equalTo(50)
		}
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
