//
//  AlertDescription.swift
//  Diary
//
//  Created by Alexander Sobolev on 11.06.2021.
//

import UIKit

extension DescriptionViewController {
    func chooseAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style) {
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
    }
}
