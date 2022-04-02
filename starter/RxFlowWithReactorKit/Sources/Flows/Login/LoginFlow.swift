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
	private let builder: LoginComponentBuilder
	
	init(
		with services: ServiceProviderType,
		builder: LoginComponentBuilder
	) {
		self.provider = services
		self.builder = builder
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
	
	// builder를 통해 viewController와 reactor를 따로 생성하면 참조하는 메모리가 달라져서 서로 연결되지 않은 상태로 동작합니다.
	// vc.reactor를 쓰던 viewController를 reactor로 생성해서 쓰던 방법을 강구해봐야 할 것 같아요.
	private func coordinateToLogin() -> FlowContributors {
		let vc = self.builder.viewController
		self.rootViewController.pushViewController(vc, animated: true)
		return .one(flowContributor: .contribute(withNextPresentable: vc,
																						 withNextStepper: vc.reactor!))
	}
}
