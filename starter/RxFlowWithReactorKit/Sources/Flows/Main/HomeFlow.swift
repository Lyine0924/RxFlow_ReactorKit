//
//  HomeFlow.swift
//  RxFlowWithReactorKit
//
//  Created by Myeongsoo Park on 2022/02/11.
//

import UIKit

import RxFlow
import RxRelay

struct HomeStepper: Stepper {
	let steps: PublishRelay<Step> = .init()
	
	var initialStep: Step {
		return SampleStep.homeIsRequired
	}
}

final class HomeFlow: Flow {
	
	// MARK: Property
	
	var root: Presentable {
		return self.rootViewController
	}
	
	let stepper: HomeStepper
	private let provider: ServiceProviderType
	private let rootViewController = UINavigationController()
	
	// MARK: Init
	
	init(
		with services: ServiceProviderType,
		stepper: HomeStepper
	) {
		self.provider = services
		self.stepper = stepper
	}
	
	deinit {
		print("\(type(of: self)): \(#function)")
	}
	
	// MARK: Navigate
	
	func navigate(to step: Step) -> FlowContributors {
		return .none
	}
}
