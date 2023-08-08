//
//  ViewController.swift
//  Budget Buddy
//
//  Created by Nicholas McGinnis on 8/6/23.
//

import UIKit

class ViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    var calculatedSalePrice = 0.00 {
        didSet {
            salePriceLabel.text = "$\(String(format: "%.2f", calculatedSalePrice))"
        }
    }
    
    var descriptionLabel: UILabel!
    var salePriceLabel: UILabel!
    var originalPriceLabel: UILabel!
    var salePercentLabel: UILabel!
    var taxRateLabel: UILabel!
    
    var originalPriceTextField: UITextField! { didSet {originalPriceTextField.addDoneToolBar()} }
    var salePercentTextField: UITextField! { didSet {salePercentTextField.addDoneToolBar()} }
    var taxRateTextField: UITextField! { didSet {taxRateTextField.addDoneToolBar()} }
    
    var calcBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        let localTaxRate = defaults.object(forKey: "myLocalTaxRate") as? Double ?? 0.00
        
        view.backgroundColor = UIColor.white
        
        descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "Sale Price:"
        descriptionLabel.textColor = UIColor.black
        descriptionLabel.font = UIFont(name: "Helvetica", size: 18)
        view.addSubview(descriptionLabel)
        
        salePriceLabel = UILabel()
        salePriceLabel.translatesAutoresizingMaskIntoConstraints = false
        salePriceLabel.text = "$\(String(format: "%.2f", calculatedSalePrice))"
        salePriceLabel.textColor = UIColor.black
        salePriceLabel.font = UIFont(name: "Helvetica", size: 50)
        view.addSubview(salePriceLabel)
        
        originalPriceLabel = UILabel()
        originalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        originalPriceLabel.text = "Original Price"
        originalPriceLabel.textColor = UIColor.black
        originalPriceLabel.font = UIFont(name: "Helvetica", size: 18)
        view.addSubview(originalPriceLabel)
        
        originalPriceTextField = UITextField()
        originalPriceTextField.translatesAutoresizingMaskIntoConstraints = false
        originalPriceTextField.layer.borderWidth = 1
        originalPriceTextField.layer.cornerRadius = 10
        originalPriceTextField.layer.borderColor = UIColor.black.cgColor
        originalPriceTextField.font = UIFont(name: "Helvetica", size: 18)
        originalPriceTextField.textColor = UIColor.black
        originalPriceTextField.keyboardType = .decimalPad
        originalPriceTextField.setLeftPaddingPoints(10)
        originalPriceTextField.clearsOnBeginEditing = true
        originalPriceTextField.attributedPlaceholder = NSAttributedString(
            string: "49.99",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
        view.addSubview(originalPriceTextField)
        
        salePercentLabel = UILabel()
        salePercentLabel.translatesAutoresizingMaskIntoConstraints = false
        salePercentLabel.text = "Sale Percentage"
        salePercentLabel.textColor = UIColor.black
        salePercentLabel.font = UIFont(name: "Helvetica", size: 18)
        view.addSubview(salePercentLabel)
        
        salePercentTextField = UITextField()
        salePercentTextField.translatesAutoresizingMaskIntoConstraints = false
        salePercentTextField.layer.borderWidth = 1
        salePercentTextField.layer.cornerRadius = 10
        salePercentTextField.layer.borderColor = UIColor.black.cgColor
        salePercentTextField.font = UIFont(name: "Helvetica", size: 18)
        salePercentTextField.textColor = UIColor.black
        salePercentTextField.keyboardType = .decimalPad
        salePercentTextField.setLeftPaddingPoints(10)
        salePercentTextField.clearsOnBeginEditing = true
        salePercentTextField.attributedPlaceholder = NSAttributedString(
            string: "15",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
        view.addSubview(salePercentTextField)
        
        taxRateLabel = UILabel()
        taxRateLabel.translatesAutoresizingMaskIntoConstraints = false
        taxRateLabel.text = "Local Tax Rate"
        taxRateLabel.textColor = UIColor.black
        taxRateLabel.font = UIFont(name: "Helvetica", size: 18)
        view.addSubview(taxRateLabel)
        
        taxRateTextField = UITextField()
        taxRateTextField.translatesAutoresizingMaskIntoConstraints = false
        taxRateTextField.layer.borderWidth = 1
        taxRateTextField.layer.cornerRadius = 10
        taxRateTextField.layer.borderColor = UIColor.black.cgColor
        taxRateTextField.font = UIFont(name: "Helvetica", size: 18)
        taxRateTextField.textColor = UIColor.black
        taxRateTextField.keyboardType = .decimalPad
        taxRateTextField.setLeftPaddingPoints(10)
        taxRateTextField.text = String(localTaxRate)
        taxRateTextField.clearsOnBeginEditing = true
        taxRateTextField.attributedPlaceholder = NSAttributedString(
            string: "7",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
        view.addSubview(taxRateTextField)
        
        calcBtn = UIButton()
        calcBtn.translatesAutoresizingMaskIntoConstraints = false
        calcBtn.setTitle("Calculate", for: .normal)
        calcBtn.setTitleColor(UIColor.black, for: .normal)
        calcBtn.titleLabel?.font = UIFont(name: "Helvetica", size: 20)
        calcBtn.backgroundColor = UIColor.green
        calcBtn.layer.borderWidth = 1
        calcBtn.layer.borderColor = UIColor.green.cgColor
        calcBtn.layer.cornerRadius = 10
        calcBtn.layer.masksToBounds = true
        calcBtn.addTarget(self, action: #selector(calcBtnTapped), for: .touchUpInside)
        view.addSubview(calcBtn)
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            descriptionLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50),
            
            salePriceLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            salePriceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            
            originalPriceLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            originalPriceLabel.topAnchor.constraint(equalTo: salePriceLabel.bottomAnchor, constant: 20),
            originalPriceLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
            
            originalPriceTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            originalPriceTextField.topAnchor.constraint(equalTo: originalPriceLabel.bottomAnchor, constant: 5),
            originalPriceTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
            originalPriceTextField.heightAnchor.constraint(equalToConstant: 40),
            
            salePercentLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            salePercentLabel.topAnchor.constraint(equalTo: originalPriceTextField.bottomAnchor, constant: 20),
            
            salePercentTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            salePercentTextField.topAnchor.constraint(equalTo: salePercentLabel.bottomAnchor, constant: 5),
            salePercentTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
            salePercentTextField.heightAnchor.constraint(equalToConstant: 40),
            
            taxRateLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            taxRateLabel.topAnchor.constraint(equalTo: salePercentTextField.bottomAnchor, constant: 20),
            
            taxRateTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            taxRateTextField.topAnchor.constraint(equalTo: taxRateLabel.bottomAnchor, constant: 5),
            taxRateTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
            taxRateTextField.heightAnchor.constraint(equalToConstant: 40),
            
            calcBtn.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            calcBtn.topAnchor.constraint(equalTo: taxRateTextField.bottomAnchor, constant: 50),
            calcBtn.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
            calcBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    
    @objc func calcBtnTapped() {
        guard let tax = Double((taxRateTextField?.text)!) else { return }
        guard let salePercent = Double((salePercentTextField?.text)!) else { return }
        guard let originalPrice = Double((originalPriceTextField?.text)!) else { return }
        
        defaults.set(tax, forKey: "myLocalTaxRate")
        
        var calcTax = (tax / 100) + 1
        var calcSalePrice = originalPrice / ((salePercent / 100) + 1)
        let rate = calcSalePrice * calcTax
        
        calculatedSalePrice = rate
    }
    
}

extension UITextField {
    func addDoneToolBar(onDone: (target: Any, action: Selector)? = nil) {
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))
        
        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()
        
        self.inputAccessoryView = toolbar
    }
    @objc func doneButtonTapped() {    self.resignFirstResponder() }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
