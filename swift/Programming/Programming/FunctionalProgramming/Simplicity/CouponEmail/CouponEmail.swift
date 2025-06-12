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

struct Email {
    var from: String
    var to: String
    var subject: String
    var body: String
}

func fetchCouponsFromDB() -> [Coupon] {
    var coupons: [Coupon] = []
    coupons.append(Coupon(code: "ABC123", rank: "best"))
    coupons.append(Coupon(code: "XYZ789", rank: "good"))
    coupons.append(Coupon(code: "PQR456", rank: "good"))
    return coupons
}

func fetchSubscribersFromDB() -> [Subscriber] {
    var subscribers: [Subscriber] = []
    subscribers.append(Subscriber(email: "alice@example.com", recCount: 12))
    subscribers.append(Subscriber(email: "bob@example.com", recCount: 5))
    return subscribers
}

func fetchSubscribersFromDB(_ pages: Int) -> [Subscriber] {
    var subscribers: [Subscriber] = []
    subscribers.append(Subscriber(email: "alice@example.com", recCount: 12))
    subscribers.append(Subscriber(email: "bob@example.com", recCount: 5))
    return subscribers
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

func emailForSubscriber(_ subscriber: Subscriber, _ goods: [String], _ bests: [String]) -> Email {
    var rank = subCouponRank(subscriber)
    
    if rank == "best" {
        return Email(from: "newsletters@example.com", to: subscriber.email, subject: "Your best weekly coupons inside", body: "Here are the best coupons: " + bests.joined(separator: ","))
    } else {
        return Email(from: "newsletters@example.com", to: subscriber.email, subject: "Your good weekly coupons inside", body: "Here are the best coupons: " + goods.joined(separator: ","))
    }
}

func emailsForSubscribers(_ subscribers: [Subscriber], _ goods: [String], _ bests: [String]) -> [Email] {
    var emails: [Email] = []
    for subscriber in subscribers {
        emails.append(emailForSubscriber(subscriber, goods, bests))
    }
    return emails
}

func sendIssue() {
    var coupons = fetchCouponsFromDB()
    var goodCoupons = selectCouponsByRank(coupons, "good")
    var bestCoupons = selectCouponsByRank(coupons, "best")
    var subscribers = fetchSubscribersFromDB()
    let emails = emailsForSubscribers(subscribers, goodCoupons, bestCoupons)
    
    for email in emails {
        print(email)
    }
}

func sendIssueScale() {
    var coupons = fetchCouponsFromDB()
    var goodCoupons = selectCouponsByRank(coupons, "good")
    var bestCoupons = selectCouponsByRank(coupons, "best")
    var page = 0;
    var subscribers = fetchSubscribersFromDB(page)
    
    while(subscribers.count > 0) {
        let emails = emailsForSubscribers(subscribers, goodCoupons, bestCoupons)
        for email in emails {
            print(email)
        }
        page += 1
        subscribers = fetchSubscribersFromDB(page)
    }
    

}
