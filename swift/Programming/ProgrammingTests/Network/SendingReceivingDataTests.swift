//
//  SendingReceivingData.swift
//  Programming
//
//  Created by ke on 1/4/25.
//

import Testing

struct SendingReceivingDataTests {
    @Test func testSendingData() async {
        await SendingData.sendData()
    }
    
    @Test func testReceivingData() async {
        await ReceivingData.receivingData()
    }
}
