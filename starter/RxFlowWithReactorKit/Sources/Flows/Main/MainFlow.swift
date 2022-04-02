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
	
	enum TabIndex: Int {
		case home = 0
		case middle = 1
		case setting = 2
	}
	
	var root: Presentable {
		return self.rootViewController
	}
	
	let rootViewController = UITabBarController()
	let homeFlow: HomeFlow
	let middleFlow: MiddleFlow
	let settingFlow: SettingFlow
	
	init(dependency: MainFlowComponent) {
		self.homeFlow = dependency.homeFlowBuilder.flow
		self.middleFlow = .init(with: dependency.serviceBuilder.provider, stepper: .init())
		self.settingFlow = .init(with: dependency.serviceBuilder.provider, stepper: .init())
	}
	
	func navigate(to step: Step) -> FlowContributors {
		guard let step = step.asSampleStep else { return .none }
		
		switch step {
			case .loginIsRequired:
				return .end(forwardToParentFlowWithStep: SampleStep.loginIsRequired)
			case .mainTabBarIsRequired:
				return coordinateToMainTabBar()
			case .middleIsRequiredAgain:
				return coordinateToMiddle(step: step)
			case .settingAndAlertIsRequired(let message):
				return coordinateToSetting(with: message)
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
	
	private func coordinateToMiddle(step: Step) -> FlowContributors {
		self.rootViewController.selectedIndex = TabIndex.middle.rawValue
		return .one(flowContributor:
										.contribute(
											withNextPresentable: middleFlow,
											withNextStepper: OneStepper(withSingleStep: SampleStep.middleIsRequiredAgain)
										)
		)
	}
	
	private func coordinateToSetting(with msg: String) -> FlowContributors {
		self.rootViewController.selectedIndex = TabIndex.setting.rawValue
		return .multiple(flowContributors: [
			.contribute(withNextPresentable: settingFlow, withNextStepper: OneStepper(withSingleStep: SampleStep.settingIsRequired)),
			.contribute(withNextPresentable: settingFlow, withNextStepper: OneStepper(withSingleStep: SampleStep.alert(message: msg)))
		])
	}
}
