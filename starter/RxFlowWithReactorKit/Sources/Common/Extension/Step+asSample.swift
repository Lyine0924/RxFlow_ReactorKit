//
//  Step+asSample.swift
//  RxFlowWithReactorKit
//
//  Created by Myeongsoo Park on 2022/02/11.
//

import RxFlow

extension Step {
	var asSampleStep: SampleStep? {
		return self as? SampleStep
	}
}
