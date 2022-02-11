//
//  LoginFlow.swift
//  RxFlowWithReactorKit
//
//  Created by Myeongsoo Park on 2022/02/11.
//

import UIKit
import RxFlow

final class LoginFlow: Flow {
	var root: Presentable {
		return self.rootViewController
	}
	
	private let rootViewController: UINavigationController = .init()
	private let provider: ServiceProviderType
	
	init(with services: ServiceProviderType) {
		self.provider = services
	}
	
	deinit {
		print("\(type(of: self)): \(#function)")
	}
	
	func navigate(to step: Step) -> FlowContributors {
		return .none
	}
}
