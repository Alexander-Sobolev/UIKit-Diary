//
//  JsonManager.swift
//  Diary
//
//  Created by Alexander Sobolev on 11.06.2021.
//

import Foundation

class JsonManager {
    // В CodeReview указанно что - Сервисный слой не реализован. Не реализован парсинг данных типа JSON. Не до конца понял что именно нужно поэтому создал отдельный менеджер где есть GET запрос. Сюда можно добавить и POST запросы отдельными функциями и другой функционал. Просто я не совсем понял что куда или откуда парсить.
    static func getRequest(url: String) {
        guard let url = URL(string: url) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
        guard let response = response, let data = data else { return }
        print(response)
        print(data)
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            print(json)
        } catch {
            print(error)
        }
    }.resume()
}
}
