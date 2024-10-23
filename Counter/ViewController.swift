//
//  ViewController.swift
//  Counter
//
//  Created by Maxim Volkov on 22.10.2024.
//

import UIKit


// перечисление возможных событий,
// которые могут быть записаны в историю
enum OperationType {
    case plus
    case minus
    case refresh
    case block
}

final class ViewController: UIViewController {
    
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var plusButton: UIButton!
    @IBOutlet private weak var minusButton: UIButton!
    @IBOutlet private weak var resetButton: UIButton!
    @IBOutlet private weak var historyTextView: UITextView!
    
    private var counter: Int = 0

    @IBAction private func plusButtonTap() {
        counter += 1
        counterLabel.text = "Значение счётчика: " + String(counter)
        addEntryToHistory(typeOfOperation: .plus)
    }
    
    @IBAction private func minusButtonTap() {
        if counter > 0 {
            counter -= 1
            counterLabel.text = "Значение счётчика: " + String(counter)
            addEntryToHistory(typeOfOperation: .minus)
        } else {
            addEntryToHistory(typeOfOperation: .block)
        }
    }
    
    @IBAction private func resetButtonTap() {
        counter = 0
        counterLabel.text = "Значение счётчика: " + String(counter)
        addEntryToHistory(typeOfOperation: .refresh)
    }
    
    private func addEntryToHistory(typeOfOperation: OperationType) {
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

