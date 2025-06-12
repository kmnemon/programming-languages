//
//  CouponEmail.swift
//  Programming
//
//  Created by ke on 6/12/25.
//

struct Subscriber {
    var email: String
    var recCount: Int
}

func subCouponRank( _ subscriber: Subscriber) -> String {
    subscriber.recCount > 10 ? "best" : "good"
}

