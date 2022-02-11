//
//  MainFlow.swift
//  RxFlowWithReactorKit
//
//  Created by Myeongsoo Park on 2022/02/11.
//

import UIKit

import RxSwift
import RxFlow

final class MainFlow: Flow {
	
	var root: Presentable {
		return self.rootViewController
	}
	
	struct Dependency {
		let provider: ServiceProviderType
	}
	
	let rootViewController = UITabBarController()
	
	private let dependency: Dependency
	
	init(dependency: Dependency) {
		self.dependency = dependency
	}
	
	func navigate(to step: Step) -> FlowContributors {
		guard let step = step.asSampleStep else { return .none }
		
		switch step {
			case .loginIsRequired:
				return .end(forwardToParentFlowWithStep: SampleStep.loginIsRequired)
			case .mainTabBarIsRequired:
				return coordinateToMainTabBar()
			default:
				return .none
		}
	}
}

// MARK: - Extensions

extension MainFlow {
	private func coordinateToMainTabBar() -> FlowContributors {
		return .none
	}
}
