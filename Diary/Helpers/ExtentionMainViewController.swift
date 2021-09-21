//
//  ExtentionMainViewController.swift
//  Diary
//
//  Created by Alexander Sobolev on 11.06.2021.
//

import UIKit
import QVRWeekView
import FSCalendar
import RealmSwift

extension MainViewController: FSCalendarDelegate, FSCalendarDataSource, WeekViewDelegate {
    func eventLoadRequest(in weekView: WeekView, between startDate: Date, and endDate: Date) {
    // Данный метод eventLoadRequest вызывается для загрузки сохраненных событий. Как его использовать еще не придумал но он обязателен удалить его не могу пока
    }
    // Метод didLongPressDayView вызывается при длительном нажатии на столбец weekView. Использую чтобы инициировать создание события
    func didLongPressDayView(in weekView: WeekView, atDate date: Date) {
    // Создаю Alert для выбора внешнего вида события
        let alert = UIAlertController(title: "Выберите внешний вид события и тапните по нему второй раз.", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Компактный вид", style: .default, handler: { _ in
        let color = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 0.5)
        let newEvent = EventData(id: self.id,
                                     title: "Описание события",
                                     startDate: date,
                                     endDate: date.addingTimeInterval(60*60*1),
                                     location: "Описание события",
                                     color: color)
        newEvent.configureGradient(UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 0.5))
        self.allEvents[self.id] = newEvent
        self.id += 1
        weekView.loadEvents(withData: Array(self.allEvents.values))
        }))

        alert.addAction(UIAlertAction(title: "Средний вид", style: .default, handler: { _ in
        let color = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 0.5)
        let newEvent = EventData(id: self.id,
                                     title: "Описание события",
                                     startDate: date,
                                     endDate: date.addingTimeInterval(60*60*3),
                                     location: "Описание события",
                                     color: color)
        self.allEvents[self.id] = newEvent
        self.id += 1
        weekView.loadEvents(withData: Array(self.allEvents.values))
        }))

        alert.addAction(UIAlertAction(title: "Большой вид", style: .default, handler: { _ in
        let color = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 0.5)
        let newEvent = EventData(
                id: self.id,
                title: "Описание события",
                startDate: date,
                endDate: date.addingTimeInterval(60*60*24*3),
                location: "Описание события",
                color: color
            )
        self.allEvents[self.id] = newEvent
        self.id += 1
        weekView.loadEvents(withData: Array(self.allEvents.values))
        }))

        alert.addAction(UIAlertAction(title: "Выход", style: .cancel, handler: {_ in
            weekView.redrawEvents()
        }))

        self.present(alert, animated: true, completion: nil)
    }
    // Через if создана возможность работы с более ранними версиями IOS
    func didTapEvent(in weekView: WeekView, withId eventId: String) {
        if #available(iOS 13.0, *) {
        guard let vc = storyboard?.instantiateViewController(identifier: "DescriptionVC") else { return }
        self.present(vc, animated: true, completion: nil)
        } else {
        // Для версий IOS до 13
        let vc = storyboard?.instantiateViewController(withIdentifier: "DescriptionVC") as! DescriptionViewController
        self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
