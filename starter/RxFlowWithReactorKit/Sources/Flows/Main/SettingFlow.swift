//
//  SettingFlow.swift
//  RxFlowWithReactorKit
//
//  Created by Myeongsoo Park on 2022/02/14.
//

import UIKit

import RxFlow
import RxRelay

struct SettingStepper: Stepper {
	let steps: PublishRelay<Step> = .init()
	
	var initialStep: Step {
		return SampleStep.settingIsRequired
	}
}

final class SettingFlow: Flow {
	var root: Presentable {
		return self.rootViewController
	}
	
	private let rootViewController = UINavigationController()
	let stepper: SettingStepper
	
	private let dependency: SettingFlowComponent
	
	// MARK: Init
	
	init(
		dependency: SettingFlowComponent,
		stepper: SettingStepper
	) {
		self.dependency = dependency
		self.stepper = stepper
	}
	
	deinit {
		print("\(type(of: self)): \(#function)")
	}
	
	// MARK: Navigate
	
	func navigate(to step: Step) -> FlowContributors {
		guard let step = step.asSampleStep else { return .none }
		
		switch step {
			case .settingIsRequired:
				return coordinateToSetting()
			case .loginIsRequired:
				return .end(forwardToParentFlowWithStep: SampleStep.loginIsRequired)
			case .alert(let message):
				return navigateToAlertScreen(message: message)
			default:
				return .none
		}
	}
}

// MARK: - Extensions

private extension SettingFlow {
	func coordinateToSetting() -> FlowContributors {
		let reactor = SettingReactor(provider: self.dependency.serviceBuilder.provider)
		let vc = SettingViewController(with: reactor)
		self.rootViewController.setViewControllers([vc], animated: true)
		return .one(flowContributor: .contribute(withNextPresentable: vc,
																						 withNextStepper: reactor))
	}
	
	func navigateToAlertScreen(message: String) -> FlowContributors {
		let alert = UIAlertController(title: "Demo", message: message, preferredStyle: .alert)
		alert.addAction(.init(title: "Cancel", style: .cancel))
		rootViewController.present(alert, animated: true)
		return .none
	}
}
