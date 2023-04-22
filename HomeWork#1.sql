- [DataBase Dump](https://drive.google.com/file/d/1hETSZZ3jejX5snf_52SzC6H-9C2hfV4F/view?usp=sharing)
use `Chinook`; /*  HW1  */
-- 1. Покажите содержимое таблицы исполнителей (артистов)
select * from artist;
-- 2. Покажите фамилии и имена клиентов из города Лондон
select LastName, FirstName from customer where City = 'London';
-- 3. Покажите продажи за 2012 год, со стоимостью продаж более 4 долларов
select InvoiceId from invoice where year (InvoiceDate) = 2012 and Total > 4;
-- 4. Покажите дату продажи, адрес продажи, город в которую совершена продажа и стоимость покупки не равную 17.91. Присвоить названия столбцам InvoiceDate – ДатаПродажи, BillingAddress – АдресПродажи и BillingCity - ГородПродажи
select InvoiceDate as 'ДатаПродажи', BillingAddress as 'АдресПродажи', BillingCity as 'ГородаПродажи' from chinook.invoice where Total != 17.91;
-- 5. Покажите фамилии и имена сотрудников компании, нанятых в 2003 году из города Калгари
select LastName, FirstName from employee where year (HireDate) = 2003 and City = 'Calgary';
-- 6. Покажите канадские города, в которые были сделаны продажи в августе?
select BillingCity from invoice where BillingCountry = 'Canada' and InvoiceDate like '_%-08-%';
-- 7. Покажите Фамилии и имена работников, нанятых в октябре?
select LastName, FirstName from employee where month (HireDate) = 10;
-- 8. Покажите фамилии и имена сотрудников, занимающих должность менеджера по продажам и ИТ менеджера. Решите задание двумя способами: используя оператор 'IN', используя логические операции
select LastName, FirstName from employee where Title = 'Sales Manager' or Title = 'IT Staff';
select LastName, FirstName from employee where Title in ('Sales Manager', 'IT Staff');
select LastName, FirstName from employee where Title = 'Sales Manager' or Title = 'IT Staff';
/*  HW2  */
-- 1. Покажите фамилии и имя клиентов, у которых имя Mарк.
select LastName, FirstName from customer where FirstName = 'Mark';
-- 2. Покажите название и размер треков в Мегабайтах, применив округление до 2 знаков и отсортировав по убыванию. Столбец назовите MB.
select Name, round((Bytes/1024/1024), 2) as MB from track order by MB desc;
-- 3. Покажите возраст сотрудников, на момент оформления на работу. Вывести фамилию, имя, возраст. дату оформления и день рождения. Столбец назовите age.
select LastName, FirstName, timestampdiff(year, BirthDate, HireDate) as age, HireDate, BirthDate from employee;
-- 4. Покажите покупателей-американцев без факса.
select LastName, FirstName from customer where Country = 'USA' and Fax is null;
-- 5. Покажите почтовые адреса клиентов из домена gmail.com.
select Address, PostalCode from customer where Email like '%gmail.com';
-- 6. Покажите в алфавитном порядке все уникальные должности в компании.
select distinct Title from employee order by Title;

-- 7. Покажите самую короткую песню.
select min(Milliseconds) from track;
-- 8. Покажите название и длительность в секундах самой короткой песни. Столбец назвать sec.
select Name, min(Milliseconds), round(Milliseconds)/1000 as sec from track;
-- 9. Покажите средний возраст сотрудников, работающих в компании.
select avg(timestampdiff(year, BirthDate, HireDate)) as AverageAge from employee;
-- 10. Узнайте фамилию, имя и компанию покупателя (номер 5). Сколько заказов он сделал и на какую сумму.
select c.LastName, c.FirstName, c.Company, count(i.InvoiceId) as OrderCount, sum(i.Total) as TotalAmount from customer c join invoice i on c.CustomerId = i.CustomerId where c.CustomerId = 5 group by c.LastName, c.FirstName, c.Company;
select c.LastName, c.FirstName, c.Company, count(i.InvoiceId) as OrderCount, sum(i.Total) as TotalAmount from customer c, invoice i where c.CustomerId = i.CustomerId and c.CustomerId = 5;
select count(*), sum(total) as sum from chinook.invoice where CustomerId = 5;
-- 11. Напишите запрос, определяющий количество треков, где ID плейлиста > 15. Назовите столбцы соответственно их расположения: CONDITION & RESULT
select PlaylistId, count(TrackId) from playlisttrack where PlayListId > 15 group by PlaylistId;
select PlaylistId AS 'CONDITION', count(TrackId) as RESULT from chinook.playlisttrack where PlaylistId > 15 group by PlayListId;
-- 12. Найти все ID счет-фактур, в которых количество треков больше или равно 6 и меньше или равно 9
select invoiceId, sum(quantity) from invoiceline group by InvoiceId having sum(quantity) between 6 and 9;
select invoiceId, sum(quantity) from invoiceline group by InvoiceId having sum(quantity) >= 6 and sum(quantity) <=9;
-- 13. Покажите содержимое списка клиентов
select * from chinook.customer;
-- 14. Покажите содержимое списка клиентов. Вывести Фамилию, Имя, телефон и е-мейл клиента
select FirstName, LastName, Phone, Email from chinook.customer;
-- 15. Покажите  содержимое продаж. Вывести дату покупки, город в которую совершена продажа и стоимость покупки. Стоимость покупки назвать как "Итог"
select InvoiceDate, BillingCity, total as Итог from chinook.invoice;
-- 16. Отобрать все музыкальные треки с ценой  меньше 1 доллара.
select * from chinook.track where UnitPrice < 1;
-- 17. Отобрать все музыкальные треки с ценой больше 1 доллара.
select * from chinook.track where UnitPrice > 1;
-- 18. Отобрать все музыкальные треки с ценой не равной 1.99 доллара.
select * from chinook.track where UnitPrice <> 1.99;
-- 19. Покажите  содержимое продаж. Вывести дату покупки, город в которую совершена продажа и стоимость покупки больше 2 долл. Стоимость покупки назвать как "Итог"
select InvoiceDate,BillingCity, Total as итог from chinook.invoice where total > 2;

-- 20. Как зовут работников-продавцов в компании? Показать фамилии и имена в одном столбце назвав FULL_NAME.
select concat(LastName, ' ', FirstName) as FULL_NAME from chinook.employee;
-- 21. Отобрать все треки, композиторами которых являются только Apocalyptica и AC/DC.
select * from chinook.track where Composer = 'Apocalyptica'  OR Composer ='AC/DC';
-- 22. Показать все продажи с ценой больше 1.98 долларов и меньше 4 долларов
select * from chinook.invoice where total > 1.98 and total < 4;
select * from chinook.invoice where total between 1.99 and 3.99;
-- 23. Показать 3 композиторов из таблицы музыкальных треков
select * from chinook.track where Composer in ('AC/DC', 'Freddie Mercury', 'Bob Dylan');
-- 24. Отобрать все треки в названии которых содержится слово night.
select * from chinook.track where name like '%night%';
-- 25. Отобрать все треки, название которых начинается на букву b
select * from chinook.track where name like 'b%';
-- 26. Получить список треков в которых содержится буква b, где композиторы Apocalyptica и AC/DC
select * from chinook.track where name like '%b%' and Composer = 'Apocalyptica' OR Composer ='AC/DC';
select * from chinook.track where name like '%b%' and (Composer = 'Apocalyptica' OR Composer ='AC/DC');
select * from chinook.track where name like '%b%'and Composer in ('Apocalyptica', 'AC/DC');
/* HW3 */
-- 1. Покажите длительность самой длинной песни. Столбец назвать sec.
select Milliseconds as sec from track where Milliseconds = (select max(Milliseconds) from track);
-- 2. Покажите название и длительность в секундах самой длинной песни применив округление по правилам математики. Столбец назвать sec.
select Name, round(Milliseconds/1000) as sec from track where Milliseconds = (select max(Milliseconds) from track);
-- 3. Покажите все счёт-фактуры, стоимость которых ниже средней.
select invoiceId, Total from invoice where Total < (select avg(Total) from invoice);
-- 4. Покажите счёт-фактуру с высокой стоимостью.
select InvoiceId, Total from invoice where Total in (select max(Total) from invoice);
-- 5. Покажите города, в которых живут и сотрудники, и клиенты (используйте пример с урока № 4).
select e.City from employee e, customer c where e.City = c.City;
select city from employee where city in (select city from customer);
-- 6. Покажите имя, фамилию покупателя (номер 16), компанию и общую сумму его заказов. Столбец назовите sum.
select customer where customerId = 16; 
select FirstName, LastName, Company, (select sum(Total) from invoice where CustomerId = customer.CustomerId) as sum from customer where CustomerId = 16;
-- 7. Покажите сколько раз покупали треки группы Queen.  Количество покупок необходимо посчитать по каждому треку. Вывести название, ИД трека и количество купленных треков группы Queen. Столбец назовите total.
select * from track where composer = 'Queen';
select Quantity, TrackId from invoiceline where TrackId in (422, 424, 426, 428, 429, 430, 431, 434, 435);
select Name, TrackId, (select count(TrackId) from invoiceline where TrackId = track.TrackId) as total from track where Composer = 'Queen';
-- 8. Посчитайте количество треков в каждом альбоме. В результате вывести имя альбома и кол-во треков.
select Title, (select count(*) from track where track.AlbumId = album.AlbumId) as Track_count from album order by(Track_count);
