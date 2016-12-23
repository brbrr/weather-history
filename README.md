- [x] Создать Модель и контроллер для получения данных из базы. последний рекорд
- [x] Прирутить сериализатор для модели JSON API
- [x] Модифицировать контроллер и сералайзер для отдачи ВСЕХ записей
- [x] Добавить валидацию атрибутов модели
- [] Прикрутить девайс для регистрации пользователей
- [] сделать авторизацию через doorkeeper
- [] Доставать реальные погодные данные из погодного апи
- [] Добавить параметры запроса для выборки по дате и проверку передаваемых параметров


Нужно написать rails-приложение, которое является json api и реализует стандарт http://jsonapi.org/ используя https://github.com/rails-api/active_model_serializers . Для аутентификации и авторизации запросов используйте https://github.com/doorkeeper-gem/doorkeeper . Для регистрации пользователей можно использовать https://github.com/plataformatec/devise .

Сам API делает вот такое: раз в час с помощью https://github.com/javan/whenever и https://github.com/lostisland/faraday сохраняет текущую погоду любого города (температура, влажность, давление) в базу данных. Модель можно назвать Observation или WeatherRecord по вашему усмотрению. Приложение при GET запросе на /api/observations будет отдавать сохранённые данные в виде json. Получить эти данные (сделать запрос) можно только c oauth токеном (вот тут и используем doorkeeper для аутентификации). Также реализуйте параметры запроса, чтобы доставать данные только за определенное время (можно использовать https://github.com/activerecord-hackery/ransack).

Город выбирайте любой. Погодный API тоже можно использовать любой (к примеру, https://openweathermap.org/).

Пример пустого, но работающего приложения, где используется devise + doorkeeper + cancancan + dotenv https://github.com/rilian/devise-doorkeeper-cancan-api-example .

Постарайтесь покрыть свою домашку request тестами. Также протестируйте код, который будет брать данные о погоде с использованием https://github.com/vcr/vcr .

API ключ для погодного API, данные о выбранном городе и прочие настройки приложения храните в переменных окружения с помощью https://github.com/bkeepers/dotenv .

а сервисные объекты как раз то, что нужно использовать, чтобы хранить код, который достает данные о погоде/делает поиск по записям (если не используете ransack).
