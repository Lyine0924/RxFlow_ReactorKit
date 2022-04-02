//
//  SettingComponent.swift
//  RxFlowWithReactorKit
//
//  Created by Lyine on 2022/04/02.
//

import Foundation
import NeedleFoundation

protocol SettingDependency: Dependency {
	var serviceBuilder: ServiceProviderBuilder { get }
}

protocol SettingComponentBuilder {
	var viewController: SettingViewController { get }
}

class SettingComponent: Component<SettingDependency>, SettingComponentBuilder {
	var viewController: SettingViewController {
		let reactor = SettingReactor(provider: self.dependency.serviceBuilder.provider)
		return SettingViewController(with: reactor)
	}
}
