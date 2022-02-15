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
	let middleFlow: MiddleFlow
	let settingFlow: SettingFlow
	
	init(dependency: Dependency) {
		self.homeFlow = .init(with: dependency.provider, stepper: .init())
		self.middleFlow = .init(with: dependency.provider, stepper: .init())
		self.settingFlow = .init(with: dependency.provider, stepper: .init())
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
		
		Flows.use(
			homeFlow, middleFlow, settingFlow,
			when: .created
		) { [unowned self] homeTab, middleTab, settingTab in
			
			let homeImage = UIImage(named: "home")
			let middleImage = UIImage(named: "middle")
			let settingImage = UIImage(named: "setting")
			
			let homeItem = UITabBarItem(title: "Home", image: homeImage, selectedImage: nil)
			let middleItem = UITabBarItem(title: "Middle", image: middleImage, selectedImage: nil)
			let settingItem = UITabBarItem(title: "Setting", image: settingImage, selectedImage: nil)
			
			homeTab.tabBarItem = homeItem
			middleTab.tabBarItem = middleItem
			settingTab.tabBarItem = settingItem
			
			self.rootViewController.setViewControllers([homeTab, middleTab, settingTab], animated: true)
		}
		
		return .multiple(flowContributors: [
			.contribute(withNextPresentable: homeFlow, withNextStepper: homeFlow.stepper),
			.contribute(withNextPresentable: middleFlow, withNextStepper: middleFlow.stepper),
			.contribute(withNextPresentable: settingFlow, withNextStepper: settingFlow.stepper)
		])
	}
}
