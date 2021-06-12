# Diary
Доработка приложения согласно Code review

1. На маленьких разрешениях загрузочный экран съезжает. Не выставлены constraints - исправлено
3. Работает только с iOS 13.0 и выше - исправлено работает с IOS 12.1
4. Есть лишний import - исправлено
5. Нет отступов, местами поехала табуляция, из-за чего сложно читать код - исправлено
6. Есть пустые функции - func eventLoadRequest в MainViewController вызывается для загрузки сохраненных событий. Как его использовать еще не разобрался но он обязателен удалить его не могу пока метод обязателен
7. Некоторые функции можно написать в одну строку - исправлено
8. Присутствуют большие функции, которые нужно разделить на несколько - исправлено 
9. Некоторые переменные можно объявить константами - не нашел решения методом перебора заменял по очереди var на let приложение не компилировалось
10. Есть небезопасное раскрытие опционала - исправлено
11. Архитектура составлена по-умолчанию. MVC. Есть сервис для работы с БД. Вся остальная логика во вьюконтроллерах - по максимуму постарался вынести логику из ViewControllers
12. Сервисный слой не реализован. Не реализован парсинг данных типа JSON - добавил сервис для работы с JSON
13. .gitignore не настроен - исправлено

## Frameworks
Realm, FSCalendar, QVRWeekView

## Screenshots

![Launch Screen](https://github.com/Alexander-Sobolev/Diary/blob/main/Diary/Screenshots/Scrieenshot01.png?raw=true)
![Main Screen](https://github.com/Alexander-Sobolev/Diary/blob/main/Diary/Screenshots/Screenshot02.png?raw=true)
![DescriotionVC Screen](https://github.com/Alexander-Sobolev/Diary/blob/main/Diary/Screenshots/Screenshot03.png?raw=true)
