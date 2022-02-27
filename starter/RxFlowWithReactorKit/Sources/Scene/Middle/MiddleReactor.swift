//
//  MiddleReactor.swift
//  RxFlowWithReactorKit
//
//  Created by Myeongsoo Park on 2022/02/14.
//

import ReactorKit
import RxRelay
import RxFlow

final class MiddleReactor: Reactor, Stepper {
	
	enum Action {
		case detailButtonDidTap
		case twoFlowButtonDidTap
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

// MARK: - Extension

extension MiddleReactor {
	func mutate(action: Action) -> Observable<Mutation> {
		switch action {
			case .detailButtonDidTap:
				steps.accept(SampleStep.middleDetailIsRequired)
				return .empty()
				
			case .twoFlowButtonDidTap:
				steps.accept(SampleStep.settingAndAlertIsRequired(message: "This is from middle twoFlowButton"))
				return .empty()
		}
	}
}
