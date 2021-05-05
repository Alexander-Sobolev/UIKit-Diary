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
            // Создаю Alert для выбора изображения
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let cameraIcon = #imageLiteral(resourceName: "camera")
            let photoIcon = #imageLiteral(resourceName: "photo")
            let photo = UIAlertAction(title: "Фото", style: .default) { _ in
                self.chooseImage(sourse: .camera)
            }
            photo.setValue(photoIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            let camera = UIAlertAction(title: "Галерея", style: .default) { _ in
                self.chooseImage(sourse: .photoLibrary)
            }
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            let cancel = UIAlertAction(title: "Выход", style: .cancel)
            alert.addAction(photo)
            alert.addAction(cancel)
            alert.addAction(camera)
            present(alert, animated: true)
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
        let description = Model(id: "", dateStart: date, dateStartDay: "", dateFinish: date, name: name.text!, descript: descript.text!, imageData: imageData)
        StorageManager.saveObject(description)
    }
    // Скрываю экран VC при нажатии на Cancel
    @IBAction func buttonCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}
    
// MARK: - Text Field Delegate
extension DescriptionViewController: UITextFieldDelegate {
    // Скрытие клавиатуры по тапу на кнопку
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // Если заполнены оба поля name и descript кнопка buttomSave доступна
    @objc private func textFieldChanged() {
        if name.text!.isEmpty == false && descript.text?.isEmpty == false {
            buttomSave.isEnabled = true
        } else {
            buttomSave.isEnabled = false
        }
    }
}

// MARK: - Extention For Image
extension DescriptionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // Метод для выбора источника изображения
    func chooseImage(sourse: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourse) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = sourse
            present(imagePicker, animated: true)
        }
    }
    // Метод для присвоения изображения
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        addImage.image = info[.editedImage] as? UIImage
        addImage.contentMode = .scaleAspectFill
        addImage.clipsToBounds = true
        imageChanged = true
        dismiss(animated: true)
    }
}
