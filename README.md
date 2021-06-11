# Diary
Доработка приложения согласно Code review

На маленьких разрешениях загрузочный экран съезжает. Не выставлены constraints - исправлено
Работает только с iOS 13.0 и выше - исправлено работает с IOS 12.1
Есть лишний import - исправлено
Нет отступов, местами поехала табуляция, из-за чего сложно читать код - исправлено
Есть пустые функции - func eventLoadRequest в MainViewController вызывается для загрузки сохраненных событий. Как его использовать еще не разобрался но он обязателен удалить его не могу пока
Некоторые функции можно написать в одну строку - исправлено
Присутствуют большие функции, которые нужно разделить на несколько - исправлено создана отдельная функция по созданию UIAlertController
Некоторые переменные можно объявить константами - не нашел решения методом перебора заменял по очереди var на let приложение не компилировалось
Есть небезопасное раскрытие опционала - исправлено
 Архитектура составлена по-умолчанию. MVC. Есть сервис для работы с БД. Вся остальная логика во вьюконтроллерах - по максимуму постарался вынести логику из ViewControllers
 Сервисный слой не реализован. Не реализован парсинг данных типа JSON - добавил сервис для работы с JSON
.gitignore не настроен - исправлено

## Frameworks
Realm, FSCalendar, QVRWeekView

## Screenshots

![Launch Screen](https://github.com/Alexander-Sobolev/Diary/blob/main/Diary/Screenshots/Scrieenshot01.png?raw=true)
![Main Screen](https://github.com/Alexander-Sobolev/Diary/blob/main/Diary/Screenshots/Screenshot02.png?raw=true)
![DescriotionVC Screen](https://github.com/Alexander-Sobolev/Diary/blob/main/Diary/Screenshots/Screenshot03.png?raw=true)
