//
//  ViewController.swift
//  ITRexTask
//
//  Created by Valera Sysov on 18.02.22.
//

import UIKit

final class CurrencyExchangeViewController: UIViewController {
    
    let networkManager = NetworkManager()
    let СountryСurrency = ["BYN": "🇧🇾", "USD": "🇺🇸", "RUB": "🇷🇺", "EUR": "🇪🇺"]
    
    lazy var firstCurrency = "BYN" {
        didSet {
            networkManager.fetchJSON(firstCurrent: firstCurrency) { [weak self] result in
                guard let self = self else { return }
                self.currencyCode.removeAll()
                self.values.removeAll()
                self.currencyCode.append(contentsOf: result.rates.keys)
                self.values.append(contentsOf: result.rates.values)
                let index = self.currencyCode.firstIndex(where: { $0 == self.secondCurrency })
                guard let index = index else {return}
                self.activeCurrency = self.values[index]
                DispatchQueue.main.async {
                    self.reloadData()
                }
            }
        }
    }
    lazy var secondCurrency = "USD" {
        didSet {
            let index = self.currencyCode.firstIndex(where: { $0 == self.secondCurrency })
            guard let index = index else {return}
            self.activeCurrency = self.values[index]
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    lazy var currencyCode: [String] = []
    lazy var values: [Double] = []
    lazy var activeCurrency = 0.0
    
    let FirstExchangeTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .black
        textField.text = "0.0"
        textField.textAlignment = .center
        textField.font = .boldSystemFont(ofSize: 25)
        textField.textColor = .white
        textField.minimumFontSize = 12
        textField.adjustsFontSizeToFitWidth = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(updateFirstExchangeTextField), for: .editingChanged)
        return textField
    }()
    
    let changeCurrencyExchangeFirstButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(changeCurrencyFirstButtonPress), for: .touchUpInside)
        return button
    }()
    
    let SecondExchangeTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .black
        textField.textAlignment = .center
        textField.font = .boldSystemFont(ofSize: 25)
        textField.textColor = .white
        textField.minimumFontSize = 12
        textField.adjustsFontSizeToFitWidth = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(updateSecondExchangeTextField), for: .editingChanged)
        return textField
    }()
    
    let changeCurrencyExchangeSecondButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(changeCurrencySecondButtonPress), for: .touchUpInside)
        return button
    }()
    
    let firstСountryСurrencyLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 21)
        label.textColor = .white
        label.backgroundColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let secondСountryСurrencyLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 21)
        label.textColor = .white
        label.backgroundColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConstrains()
        networkingManager()
        view.backgroundColor = .systemBackground
    }
    
    private func networkingManager() {
        networkManager.fetchJSON(firstCurrent: firstCurrency) { [weak self] result in
            guard let self = self else { return }
            self.currencyCode.append(contentsOf: result.rates.keys)
            self.values.append(contentsOf: result.rates.values)
            let index = self.currencyCode.firstIndex(where: { $0 == self.secondCurrency })
            guard let index = index else {return}
            self.activeCurrency = self.values[index]
        }
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    @objc private func updateFirstExchangeTextField() {
        guard let amountText = FirstExchangeTextField.text, let theAmountText = Double(amountText) else { return SecondExchangeTextField.text = ""
        }
        if FirstExchangeTextField.text != "" {
            let total = theAmountText * activeCurrency
            SecondExchangeTextField.text = String(format: "%.2F", total)
        }
    }
    
    @objc private func updateSecondExchangeTextField() {
        guard let amountText = SecondExchangeTextField.text, let theAmountText = Double(amountText) else { return
            FirstExchangeTextField.text = ""
        }
        if SecondExchangeTextField.text != "" {
            let total = theAmountText / activeCurrency
            FirstExchangeTextField.text = String(format: "%.2F", total)
        }
    }
    
    @objc private func changeCurrencyFirstButtonPress() {
        let vc = CurrencyViewController()
        vc.closure = { [weak self] item in
            guard let self = self else { return }
            self.firstCurrency = item
        }
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc private func changeCurrencySecondButtonPress() {
        let vc = CurrencyViewController()
        vc.closure = { [weak self] item in
            guard let self = self else { return }
            self.secondCurrency = item
        }
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    private func reloadData() {
        firstСountryСurrencyLabel.text = firstCurrency + " " + СountryСurrency[firstCurrency]!
        secondСountryСurrencyLabel.text = secondCurrency + " " + СountryСurrency[secondCurrency]!
        updateFirstExchangeTextField()
        updateSecondExchangeTextField()
    }
}

extension CurrencyExchangeViewController {
    func setUpConstrains() {
        
        view.addSubview(FirstExchangeTextField)
        NSLayoutConstraint.activate([
            FirstExchangeTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 320),
            FirstExchangeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            FirstExchangeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -120),
            FirstExchangeTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08)
        ])
        
        view.addSubview(changeCurrencyExchangeFirstButton)
        NSLayoutConstraint.activate([
            changeCurrencyExchangeFirstButton.topAnchor.constraint(equalTo: FirstExchangeTextField.topAnchor),
            changeCurrencyExchangeFirstButton.leadingAnchor.constraint(equalTo: FirstExchangeTextField.trailingAnchor),
            changeCurrencyExchangeFirstButton.heightAnchor.constraint(equalTo: FirstExchangeTextField.heightAnchor)
        ])
        
        view.addSubview(firstСountryСurrencyLabel)
        NSLayoutConstraint.activate([
            firstСountryСurrencyLabel.topAnchor.constraint(equalTo: FirstExchangeTextField.topAnchor),
            firstСountryСurrencyLabel.leadingAnchor.constraint(equalTo: FirstExchangeTextField.trailingAnchor),
            firstСountryСurrencyLabel.heightAnchor.constraint(equalTo: FirstExchangeTextField.heightAnchor)
        ])
        
        view.addSubview(SecondExchangeTextField)
        NSLayoutConstraint.activate([
            SecondExchangeTextField.topAnchor.constraint(equalTo: FirstExchangeTextField.topAnchor, constant: 200),
            SecondExchangeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            SecondExchangeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -120),
            SecondExchangeTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08)
        ])
        view.addSubview(changeCurrencyExchangeSecondButton)
        NSLayoutConstraint.activate([
            changeCurrencyExchangeSecondButton.topAnchor.constraint(equalTo: SecondExchangeTextField.topAnchor),
            changeCurrencyExchangeSecondButton.leadingAnchor.constraint(equalTo: SecondExchangeTextField.trailingAnchor),
            changeCurrencyExchangeSecondButton.heightAnchor.constraint(equalTo: SecondExchangeTextField.heightAnchor)
        ])
        view.addSubview(secondСountryСurrencyLabel)
        NSLayoutConstraint.activate([
            secondСountryСurrencyLabel.topAnchor.constraint(equalTo: SecondExchangeTextField.topAnchor),
            secondСountryСurrencyLabel.leadingAnchor.constraint(equalTo: SecondExchangeTextField.trailingAnchor),
            secondСountryСurrencyLabel.heightAnchor.constraint(equalTo: SecondExchangeTextField.heightAnchor)
        ])
    }
}
