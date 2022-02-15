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
	
	private let provider: ServiceProviderType
	
	// MARK: Init
	
	init(
		with services: ServiceProviderType,
		stepper: SettingStepper
	) {
		self.provider = services
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
			default:
				return .none
		}
	}
}

// MARK: - Extensions

private extension SettingFlow {
	func coordinateToSetting() -> FlowContributors {
		let reactor = SettingReactor(provider: provider)
		let vc = SettingViewController(with: reactor)
		self.rootViewController.setViewControllers([vc], animated: true)
		return .one(flowContributor: .contribute(withNextPresentable: vc,
																						 withNextStepper: reactor))
	}
}
