//
//  LoginFlowComponent.swift
//  RxFlowWithReactorKit
//
//  Created by Lyine on 2022/03/31.
//

import UIKit
import NeedleFoundation
import RxFlow

protocol LoginFlowDependency: Dependency {
	var serviceBuilder: ServiceProviderBuilder { get }
}

protocol LoginFlowComponentBuilder {
	var flow: LoginFlow { get }
	var loginBuilder: LoginComponentBuilder { get }
}

class LoginFlowComponent: Component<LoginFlowDependency>, LoginFlowComponentBuilder {
	var flow: LoginFlow {
		return LoginFlow(with: self.dependency.serviceBuilder.provider, builder: self.loginBuilder)
	}
	
	var loginBuilder: LoginComponentBuilder {
		return LoginComponent(parent: self)
	}
}


protocol LoginDependency: Dependency {
	var serviceBuilder: ServiceProviderBuilder { get }
}

protocol LoginComponentBuilder {
	var viewController: LoginVC { get }
}

class LoginComponent: Component<LoginFlowDependency>, LoginComponentBuilder {
	var viewController: LoginVC {
		let reactor = LoginReactor(dependency: .init(provider: self.dependency.serviceBuilder.provider))
		return LoginVC(with: reactor)
	}
}
