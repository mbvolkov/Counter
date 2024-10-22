//
//  ViewController.swift
//  Counter
//
//  Created by Maxim Volkov on 22.10.2024.
//

import UIKit


// перечисление возможных событий,
// которые могут быть записаны в историю
enum operationType {
    case plus
    case minus
    case refresh
    case block
}

class ViewController: UIViewController {
    
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var historyTextView: UITextView!
    
    private var counter: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func plusButtonTap() {
        counter += 1
        counterLabel.text = "Значение счётчика: " + String(counter)
        addEntryToHistory(typeOfOperation: .plus)
    }
    
    @IBAction func minusButtonTap() {
        if counter > 0 {
            counter -= 1
            counterLabel.text = "Значение счётчика: " + String(counter)
            addEntryToHistory(typeOfOperation: .minus)
        } else {
            addEntryToHistory(typeOfOperation: .block)
        }
    }
    
    @IBAction func resetButtonTap() {
        counter = 0
        counterLabel.text = "Значение счётчика: " + String(counter)
        addEntryToHistory(typeOfOperation: .refresh)
    }
    
    private func addEntryToHistory(typeOfOperation: operationType) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss: "
        
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        
        var entry: String = "\n" + dateString
        
        switch typeOfOperation {
        case .plus:
            entry.append("значение изменено на +1")
        case .minus:
            entry.append("значение изменено на -1")
        case .refresh:
            entry.append("значение сброшено")
        case .block:
            entry.append("попытка уменьшить значение счётчика ниже 0")
        }
        historyTextView.insertText(entry)
        
        // Автопрокрутка, чтобы было видно добавление
        // новой записи в UITextView
        let range = NSMakeRange(historyTextView.text.count, 0)
        historyTextView.scrollRangeToVisible(range)
    }
}

