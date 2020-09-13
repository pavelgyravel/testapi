Alexander S, [6 авг. 2020 г., 18:31:39]:
Требуется создать JSON API сервис на Ruby. В качестве веб-фреймворка, можете использовать sinatra, hanami, roda или что-нибудь другое, но не Ruby on Rails. Доспут к БД можете осуществлять с помощью ORM(active_record, sequel, rom), можете и без ORM, как посчитаете нужным. Сущности:
Юзер. Имеет только логин.
Пост, принадлежит юзеру. Имеет заголовок, содержание, айпи автора (сохраняется отдельно для каждого поста).
Оценка, принадлежит посту. Принимает значение от 1 до 5.
Экшены:

+ Создать пост. Принимает заголовок и содержание поста (не могут быть пустыми), а также логин и айпи автора. Если автора с таким логином еще нет, необходимо его создать. Возвращает либо атрибуты поста со статусом 200, либо ошибки валидации со статусом 422.

+ Поставить оценку посту. Принимает айди поста и значение, возвращает новый средний рейтинг поста. Важно: экшен должен корректно отрабатывать при любом количестве конкурентных запросов на оценку одного и того же поста.


+ Получить топ N постов по среднему рейтингу. Просто массив объектов с заголовками и содержанием.


+ Получить список айпи, с которых постило несколько разных авторов. Массив объектов с полями: айпи и массив логинов авторов.


Базу данных используем PostgreSQL. Для девелопмента написать скрипт в db/seeds.rb, который генерирует тестовые данные. Часть постов должна получить оценки. Скрипт должен использовать созданный JSON API сервер (можно посылать запросы курлом или еще чем-нибудь) Постов в базе должно быть хотя бы 200к, авторов лучше сделать в районе 100 штук, айпишников использовать штук 50 разных. Экшены должны на стандартном железе работать достаточно быстро как для указанного объема данных (быстрее 100 мс, если будет работать медленне, то ничего страшного, все равно присылайте решение), так и для намного большего, то есть нужен хороший запас в плане оптимизации запросов. Для этого можно использовать денормализацию данных и любые другие средства БД. Можно использовать любые нужные гемы, обязательно наличие спеков, хорошо покрывающих разные кейсы. Архитектуру сервиса организуйте на "свой вкус". Желательно не использовать генераторов и вообще обойтись без лишних мусорных файлов в репозитории.

по сроку не органичиваем. спокойно смотрим, читаем и говорим, когда ожидать линку на репу




=============================================================================================
=============================================================================================
=============================================================================================

Добрый день!

Выполнил задание описаное выше. Ниже кратко опишу что и как делал, что использовал и почему.

Выбор библиотек.

Я давно хотел минимально разобраться с семейством гемов trailblazer и это тестовое отлично подошло 
как поле для экспириментов. Ранее меня от вникания в trailblazer останавливало то что у них 
была средненькая документация и постоянные изменения в апи. Но сам подход к организации бизнесс-логики который
пропогандирует Ник Шаттерер очень откликается в моем сердце) Поэтому я переодически проверял как там у них дела. 
И сейчас апи вроде устаканилось и они обещают long term support для текущей версии. 
Да и документация стала намного лучше и даже практически всегда соответствует действительности :)

Фреймворк

Фреймворк я выбрал Ханами просто потому что вышеупомянутый Ник Шаттерер постоянно его упоминает в своих выступлениях.
А с синатрой я в принцыпе уже имел дело. Вернее не с синатрой а с padrino, который в основе использует синатру. 
Хотя по большому счету небыло никакой разницы в контексте данной задачи, учитывая что я использую trailblazer для 
организации бизнесс-логики, какой фреймворк использовать, ведь сейчас они используются лишь для получения запросов и отдачи 
респонсов. 

ORM

Поначалу я использовал орм, который идет вместе с ханами, но там все вроде такое же, но не совсем) 
Надоело назбираться с каждой мелочью и я переключился на знакомы active record. Какой же я был наивный,
полагая что там все пройдет гладко... На локали все было ок, но когда я залил в свой "прод" на виртуалку на диджиталоушен, столкнулся с неизвестной для меня ранее проблемой, на решение которой ушло несколько дней(

Тесты

Так получилось что ранее мне не приходилось писать тесты. В компании у нас этого не требуют( Правда я всетаки периодически поглядывал статьи о TDD и уроки про rspec поэтому общее представления всетаки имел.
И опять таки благодаря этому тестовому я поверхностно разобрался как это делается. С большой оговоркой на trailblazer.
Учитывая что я использую оперешены трейлблейзера для организации бизнесс-логики я принял решение, что будет достаточно тестировать только их, так как в котроллерах и моделях у меня особо ничего не происходит. 
Таким образм я постарался максимально упростить себе жизнь с тестами.


Примеры апи запросов можно посмотреть по ссылке ниже.
https://documenter.getpostman.com/view/2972037/TVK5eMhD


Я развернул продакшн среду на на минимальной виртуалке диджиталоушен. 
Она доступна по ip напрямую или по домену https://pavelgyravel.tk/
Но через домен получается чуть больший респонс, так как там https плюс запрос идет через cloudflare (просто у меня уже был подвязан туда домен)
  
В целом все запросы укладываются в ограничение в 100мс и даже в 50 местами, кроме запроса на получение айпишников с никнеймами. Тут чем больше данных тем дольше получается запрос, так как в принцыпе для этой выборки перебирается вся таблица с постами.
  
Кстати сейчас, после моих экспериментов, в прод базе примерно такое кол-во сущностей:
  
select count(id) from posts => 1279394  
select count(distinct author_ip) from posts => 1141  
select count(id) from rates => 47785  
select count(id) from users => 2284  
  
Спасибо что уделили внимание. 
Если возникнут дополнительные вопросы, готов обсудить.