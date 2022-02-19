//
//  SettingReactor.swift
//  RxFlowWithReactorKit
//
//  Created by Myeongsoo Park on 2022/02/14.
//

import ReactorKit
import RxRelay
import RxFlow

final class SettingReactor: Reactor, Stepper {
	
	enum Action {
		case logoutButtonDidTap
		case alertButtonDidTap
	}
	
	enum Mutation {}
	
	struct State {}
	
	// MARK: Properties
	
	let initialState: State
	private let provider: ServiceProviderType
	
	// MARK: Stepper
	
	var steps: PublishRelay<Step> = .init()
	
	init(provider: ServiceProviderType) {
		initialState = State()
		self.provider = provider
	}
}

// MARK: Mutation

extension SettingReactor {
	func mutate(action: Action) -> Observable<Mutation> {
		switch action {
			case .logoutButtonDidTap:
				return logoutButtonDidTapMutation()
			case .alertButtonDidTap:
				return alertButtonDidTapMutation()
		}
	}
}

// MARK: Mutation Impl

extension SettingReactor {
	private func logoutButtonDidTapMutation() -> Observable<Mutation> {
		return .empty()
	}
	
	private func alertButtonDidTapMutation() -> Observable<Mutation> {
		return .empty()
	}
}
