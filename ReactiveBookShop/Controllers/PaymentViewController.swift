//
//  PaymentViewController.swift
//  ReactiveBookShop
//
//  Created by Тимур Шафигуллин on 12.05.2018.
//  Copyright © 2018 Тимур Шафигуллин. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PaymentViewController: UIViewController {
    
    let throttleInterval = 0.1
    let cellIdentifier = "bookPriceCell"
    var selectedBooks = Variable([Book]())
    let disposeBag = DisposeBag()
    
    var validPhoneNumber = Variable(false)
    var validCardNumber = Variable(false)
    var validDateExparation = Variable(false)
    var validCVV = Variable(false)
    let cardType: Variable<CardType> = Variable(CardType.Unknown)
    
    @IBOutlet weak var resultPriceLabel: UILabel!
    @IBOutlet weak var resultBookCountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cardNumberTextFiled: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var dateExpireTextField: UITextField!
    @IBOutlet weak var cvvTextField: UITextField!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var cardImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedBooks.value = Array(ShoppingCart.shared.selectedBooks.value)
        preparePayButton()
        setupInitialState()
        setupPhoneNumberValidation()
        setupCardNumberValidation()
        setupDateExparationValidation()
        setupCvvValidation()
        setupAllValid()
    }
    
    func setupPhoneNumberValidation() {
        validPhoneNumber.asObservable()
            .subscribe(onNext: { self.phoneNumberTextField.set(valid: $0) })
            .disposed(by: disposeBag)
        
        let phoneNumberIsValid = phoneNumberTextField
            .rx
            .text
            .throttle(throttleInterval, scheduler: MainScheduler.instance)
            .map { Validator.phoneNumber($0) }
        
        phoneNumberIsValid
            .subscribe(onNext: { self.validPhoneNumber.value = $0 })
            .disposed(by: disposeBag)
    }
    
    func setupCardNumberValidation() {
        validCardNumber.asObservable()
            .subscribe(onNext: { self.cardNumberTextFiled.set(valid: $0) })
            .disposed(by: disposeBag)
        
        cardType.asObservable()
            .subscribe(onNext: { self.cardImageView.image = $0.image })
            .disposed(by: disposeBag)
        
        let creditCardValid = cardNumberTextFiled
            .rx
            .text
            .throttle(throttleInterval, scheduler: MainScheduler.instance)
            .map { self.validate(cardText: $0) }
        
        creditCardValid
            .subscribe(onNext: { self.validCardNumber.value = $0 })
            .disposed(by: disposeBag)
    }
    
    func setupDateExparationValidation() {
        validDateExparation.asObservable()
            .subscribe(onNext: { self.dateExpireTextField.set(valid: $0) })
            .disposed(by: disposeBag)
        
        let dateExparationValid = dateExpireTextField
            .rx
            .text
            .throttle(throttleInterval, scheduler: MainScheduler.instance)
            .map { Validator.dateExparation($0) }
        
        dateExparationValid
            .subscribe(onNext: { self.validDateExparation.value = $0 })
            .disposed(by: disposeBag)
    }
    
    func setupCvvValidation() {
        validCVV.asObservable()
            .subscribe(onNext: { self.cvvTextField.set(valid: $0) })
            .disposed(by: disposeBag)
        
        cvvTextField
            .rx
            .text
            .throttle(throttleInterval, scheduler: MainScheduler.instance)
            .subscribe(onNext: { self.validCVV.value = Validator.cvvCode($0) })
            .disposed(by: disposeBag)
    }
    
    func setupAllValid() {
        let everythingValid = Observable.combineLatest(validPhoneNumber.asObservable(), validCardNumber.asObservable(), validCVV.asObservable(), validDateExparation.asObservable()) {
            return $0 && $1 && $2 && $3
        }
        
        everythingValid
            .bind(to: payButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    func preparePayButton() {
        payButton.setTitleColor(.gray, for: .disabled)
    }
    
    func setupInitialState() {
        phoneNumberTextField.layer.borderWidth = 1
        phoneNumberTextField.layer.cornerRadius = 8
        cardNumberTextFiled.layer.borderWidth = 1
        cardNumberTextFiled.layer.cornerRadius = 8
        dateExpireTextField.layer.borderWidth = 1
        dateExpireTextField.layer.cornerRadius = 8
        cvvTextField.layer.borderWidth = 1
        cvvTextField.layer.cornerRadius = 8
        
        var price = 0.0
        selectedBooks.value.forEach { price += $0.price }
        resultPriceLabel.text = String(price)
        resultBookCountLabel.text = String(selectedBooks.value.count)
    }
    
    @IBAction func onPayButtonClick(_ sender: UIButton) {
        
    }
}

//Card validation
extension PaymentViewController {
    
    func validate(cardText: String?) -> Bool {
        guard let cardText = cardText else { return false }
        let noWhitespace = cardText.rw_removeSpaces()
        
        cardType.value = CardType.fromString(string: noWhitespace)
        cardNumberTextFiled.text = self.cardType.value.format(noSpaces: noWhitespace)
        if noWhitespace.count == self.cardType.value.expectedDigits {
            self.dateExpireTextField.becomeFirstResponder()
        }
        
        guard cardType.value != .Unknown else {
            //Definitely not valid if the type is unknown.
            return false
        }
        
        guard noWhitespace.rw_isLuhnValid() else {
            //Failed luhn validation
            return false
        }
        
        return noWhitespace.count == self.cardType.value.expectedDigits
    }

}
