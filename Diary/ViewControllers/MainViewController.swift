//
//  MainViewController.swift
//  Diary
//
//  Created by Alexander Sobolev on 02.05.2021.
//

import UIKit
import QVRWeekView
import FSCalendar
import RealmSwift
// Не решенная еще задача как с БД добавить данные в поля выбранные для событий
class MainViewController: UIViewController {
    // Создаю автообновляемый тип контейнера который возвращает текущее состояние хранилища
    var model: Results<Model>!
    
    var currentDate = Date()
    // Три строки с GitHub разработчика фреймворка QVRWeekView для сохранения в CoreData
    // Не решена еще задача как приспособить для Realm
    var allEvents: [Int: EventData] = [:]
    var eventsSortedByDay: [Date: [EventData]] = [:]
    var id: Int = 0
    
    @IBOutlet weak var calendear: FSCalendar!
    @IBOutlet weak var weekView: WeekView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Делаю запрос данных из Realm
        model = realm.objects(Model.self)
        
        selectDate(date: currentDate)
        // Настраиваю делегатов
        calendear.delegate = self
        calendear.dataSource = self
        weekView.delegate = self
        // Меняю внешний вид weekView
        weekView.mainBackgroundColor = .white
        weekView.todayViewColor = .white
        weekView.visibleDaysInPortraitMode = 1
        weekView.topBarColor = #colorLiteral(red: 0.9523287416, green: 0.9492221475, blue: 0.9522970319, alpha: 1)
        weekView.defaultDayViewColor = .white
        weekView.passedDayViewColor = .white
        weekView.weekendDayViewColor = .white
        weekView.dayViewDashedSeparatorColor = .white
        weekView.passedWeekendDayViewColor = .white
        weekView.sideBarWidth = 40
        weekView.dayViewHourIndicatorColor = .blue
    }
    // Метод синхронизирует выбранную дату в calendear и weekView
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        currentDate = date
        selectDate(date: currentDate)
    }
    // Метод меняет дату в calendear при листании страниц weekView
    func activeDayChanged(in weekView: WeekView, to date: Date) {
        currentDate = date
        calendear.select(date)
    }
    // Метод выбора даты для calendear и weekView
    func selectDate(date: Date) {
        calendear.select(date)
        weekView.showDay(withDate: date)
    }
}
    // Добавляю протоколы
extension MainViewController: FSCalendarDelegate, FSCalendarDataSource, WeekViewDelegate {
    func eventLoadRequest(in weekView: WeekView, between startDate: Date, and endDate: Date) {
        // Данный метод не использую еще
    }
    // Метод вызывается при длительном нажатии на столбец weekView. Использую чтобы инициировать создание события
    func didLongPressDayView(in weekView: WeekView, atDate date: Date) {
        // Создаю Alert для выбора внешнего вида события
        let alert = UIAlertController(title: "Выберите внешний вид события и тапните по нему второй раз.",
                                      message: nil,
                                      preferredStyle: .alert)
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
    // Данный метод didTapEvent по задумке разработчиков фреймворка QVRWeekView используется чтобы запрашивать редактирование или удаление события. Я приспособил его для перехода на ViewController на котором добавляем события
    func didTapEvent(in weekView: WeekView, withId eventId: String) {
        if #available(iOS 13.0, *) {
            guard let vc = storyboard?.instantiateViewController(identifier: "DescriptionVC") else { return }
            self.present(vc, animated: true, completion: nil)
            } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "DescriptionVC") as! DescriptionViewController
            self.navigationController?.pushViewController(vc, animated: true)
            }
    // Использую для возврата со второго View и одновременного сохранения событий
        }
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let descroptionVC = segue.source as? DescriptionViewController else { return }
        descroptionVC.saveDescription()
    }
}
