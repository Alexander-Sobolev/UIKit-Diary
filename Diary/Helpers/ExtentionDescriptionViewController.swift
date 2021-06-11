//
//  ExtentionDescriptionViewController.swift
//  Diary
//
//  Created by Alexander Sobolev on 11.06.2021.
//

import UIKit
extension DescriptionViewController: UITextFieldDelegate {
    // Скрытие клавиатуры по тапу на кнопку
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // Если заполнены оба поля name и descript кнопка buttomSave доступна
    @objc func textFieldChanged() {
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
