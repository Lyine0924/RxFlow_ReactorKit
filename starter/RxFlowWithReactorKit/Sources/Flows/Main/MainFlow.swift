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
	let homeFlow: HomeFlow
	
	init(dependency: Dependency) {
		self.homeFlow = .init(with: dependency.provider, stepper: .init())
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
		
		Flows.use(homeFlow, when: .created) { [unowned self] homeTab in
			let homeImage = UIImage(named: "home")
			
			let homeItem = UITabBarItem(title: "Home", image: homeImage, selectedImage: nil)
			
			homeTab.tabBarItem = homeItem
			
			self.rootViewController.setViewControllers([homeTab], animated: true)
		}
		
		return .multiple(flowContributors: [
			.contribute(withNextPresentable: homeFlow, withNextStepper: homeFlow.stepper)
		])
	}
}
