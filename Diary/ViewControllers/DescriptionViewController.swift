//
//  DescriptionViewController.swift
//  Diary
//
//  Created by Alexander Sobolev on 02.05.2021.
//

import UIKit

class DescriptionViewController: UITableViewController {
    
    var imageChanged = false

    @IBOutlet weak var buttomSave: UIBarButtonItem!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var descript: UITextField!
    @IBOutlet weak var addImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    // Убираю нижнюю разлиновку
    tableView.tableFooterView = UIView()
    // Выключаю кнопку сохранения покa не заполнены оба поля name и descript
    buttomSave.isEnabled = false
    descript.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }

// MARK: - Table View Delegate
    // Метод для выбора ячейки
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            // Вызываю Alert
            chooseAlertController(withTitle: nil, message: nil, style: .actionSheet)
        } else {
            // Скрываю клавиатуру
            view.endEditing(true)
        }
    }
    // Создаю метод сохранения данных 
    func saveDescription() {
        let date = Date()
        var image: UIImage?
        if imageChanged {
            image = addImage.image
        } else {
            image = #imageLiteral(resourceName: "Temporarily") // Ставлю заглушку. Временное решение ищу другой вариант.
        }
        let imageData = image?.pngData()
        let description = Model(id: "", dateStart: date, dateStartDay: "", dateFinish: date, name: name.text ?? "", descript: descript.text ?? "", imageData: imageData)
        StorageManager.saveObject(description)
    }
    // Скрываю экран VC при нажатии на Cancel
    @IBAction func buttonCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}
