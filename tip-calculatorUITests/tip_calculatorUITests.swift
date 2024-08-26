//
//  tip_calculatorUITests.swift
//  tip-calculatorUITests
//
//  Created by MATHEUS PAES CRESCENCIO on 12/08/24.
//

import XCTest

final class tip_calculatorUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    private var screen: CalculatorScreen {
        CalculatorScreen(app: app)
    }
    
    override func setUp() {
        super.setUp()
        app = .init()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        app = nil
    }
    
    func testResultViewDefaultValues() {
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "$0")
        XCTAssertEqual(screen.totalBillValueLabel.label, "$0")
        XCTAssertEqual(screen.totalTipValueLabel.label, "$0")
    }
    
    func testRegularTip() {
        // User enters a $100 bill
        screen.enterBill(amount: 100)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "R$ 100")
        XCTAssertEqual(screen.totalBillValueLabel.label, "R$ 100")
        XCTAssertEqual(screen.totalTipValueLabel.label, "R$ 0")

        // User selects 10%
        screen.selectTip(tip: .tenPercent)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "R$ 110")
        XCTAssertEqual(screen.totalBillValueLabel.label, "R$ 110")
        XCTAssertEqual(screen.totalTipValueLabel.label, "R$ 10")

        // User selects 15%
        screen.selectTip(tip: .fifteenPercent)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "R$ 115")
        XCTAssertEqual(screen.totalBillValueLabel.label, "R$ 115")
        XCTAssertEqual(screen.totalTipValueLabel.label, "R$ 15")

        // User selects 20%
        screen.selectTip(tip: .twentyPercent)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "R$ 120")
        XCTAssertEqual(screen.totalBillValueLabel.label, "R$ 120")
        XCTAssertEqual(screen.totalTipValueLabel.label, "R$ 20")

        // User splits the bill by 4
        screen.selectIncrementButton(numberOfTaps: 3)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "R$ 30")
        XCTAssertEqual(screen.totalBillValueLabel.label, "R$ 120")
        XCTAssertEqual(screen.totalTipValueLabel.label, "R$ 20")

        // User splits the bill by 2
        screen.selectDecrementButton(numberOfTaps: 2)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "R$ 60")
        XCTAssertEqual(screen.totalBillValueLabel.label, "R$ 120")
        XCTAssertEqual(screen.totalTipValueLabel.label, "R$ 20")
    }
    
    func testCustomTipAndSplitBillBy2() {
        screen.enterBill(amount: 300)
        screen.selectTip(tip: .custom(value: 200))
        screen.selectIncrementButton(numberOfTaps: 1)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "R$ 250")
        XCTAssertEqual(screen.totalBillValueLabel.label, "R$ 500")
        XCTAssertEqual(screen.totalTipValueLabel.label, "R$ 200")
    }
    
    func testResetButton() {
        screen.enterBill(amount: 300)
        screen.selectTip(tip: .custom(value: 200))
        screen.selectIncrementButton(numberOfTaps: 1)
        screen.doubleTapLogoView()
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "R$ 0")
        XCTAssertEqual(screen.totalBillValueLabel.label, "R$ 0")
        XCTAssertEqual(screen.totalTipValueLabel.label, "R$ 0")
        XCTAssertEqual(screen.billInputViewTextField.label, "")
        XCTAssertEqual(screen.splitValueLabel.label, "1")
        XCTAssertEqual(screen.customTipButton.label, "Custom tip")
    }
}
