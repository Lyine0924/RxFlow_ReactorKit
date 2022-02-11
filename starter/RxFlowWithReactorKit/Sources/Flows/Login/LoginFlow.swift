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
		guard let step = step.asSampleStep else { return .none }
		
		switch step {
			case .loginIsRequired:
				return coordinateToLogin()
			case .loginIsCompleted:
				return .end(forwardToParentFlowWithStep: SampleStep.mainTabBarIsRequired)
			default:
				return .none
		}
	}
	
	private func coordinateToLogin() -> FlowContributors {
		let reactor = LoginReactor(dependency: .init(provider: provider))
		let vc = LoginVC(with: reactor)
		self.rootViewController.pushViewController(vc, animated: true)
		return .one(flowContributor: .contribute(withNextPresentable: vc,
																						 withNextStepper: reactor))
	}
}
