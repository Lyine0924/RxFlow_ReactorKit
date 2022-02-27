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
		guard let step = step.asSampleStep else { return .none }
		
		switch step {
			case .homeIsRequired:
				return coordinateToHome()
			case .homeItemIsPicked(let movieID):
				return coordinateToHomeDetail(with: movieID)
			default:
				return .none
		}
	}
}

// MARK: - Extensions

private extension HomeFlow {
	func coordinateToHome() -> FlowContributors {
		let reactor = HomeReactor(provider: provider)
		let viewController = HomeViewController(with: reactor)
		
		self.rootViewController.setViewControllers([viewController], animated: true)
		
		return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: reactor))
	}
	
	func coordinateToHomeDetail(with ID: String) -> FlowContributors {
		let reactor = HomeDetailReactor(provider: provider)
		let vc = HomeDetatilViewController(with: reactor, title: ID)
		self.rootViewController.pushViewController(vc, animated: true)
		return .one(flowContributor: .contribute(withNextPresentable: vc,
																						 withNextStepper: reactor))
	}
}
