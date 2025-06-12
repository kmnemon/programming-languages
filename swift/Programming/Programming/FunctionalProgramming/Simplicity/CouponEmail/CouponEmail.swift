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

struct Coupon {
    var code: String
    var rank: String
}

struct Message {
    var from: String
    var to: String
    var subject: String
    var body: String
}

func subCouponRank( _ subscriber: Subscriber) -> String {
    subscriber.recCount > 10 ? "best" : "good"
}

func selectCouponsByRank(_ coupons: [Coupon], _ rank: String) -> [String] {
    var couponCodes: [String] = []
    for coupon in coupons {
        if coupon.rank == rank {
            couponCodes.append(coupon.code)
        }
    }
    return couponCodes
}

func emailForSubscriber(_ subscriber: Subscriber, _ goods: [String], _ bests: [String]) -> Message {
    var rank = subCouponRank(subscriber)
    
    if rank == "best" {
        return Message(from: "newsletters@example.com", to: subscriber.email, subject: "Your best weekly coupons inside", body: "Here are the best coupons: " + bests.joined(separator: ","))
    } else {
        return Message(from: "newsletters@example.com", to: subscriber.email, subject: "Your good weekly coupons inside", body: "Here are the best coupons: " + goods.joined(separator: ","))
    }
}
