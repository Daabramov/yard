﻿// ----------------------------------------------------------
// This Source Code Form is subject to the terms of the
// Mozilla Public License, v.2.0. If a copy of the MPL
// was not distributed with this file, You can obtain one
// at http://mozilla.org/MPL/2.0/.
// ----------------------------------------------------------
// Codebase: https://github.com/ArKuznetsov/yard/
// ----------------------------------------------------------

#Использовать logos
#Использовать tempfiles
#Использовать fs

Перем ЛогПриложения;                       // Объект       - объект записи лога приложения
Перем ОбщиеПараметры;                      // Структура    - общие параметры приложения
Перем СохрКаталогПриложения;               // Строка       - текущий каталог приложения
Перем ЭтоПриложениеEXE;                    // Булево       - Истина - выполняется скомпилированный скрипт
Перем ЭтоWindows;                          // Булево       - Истина - скрипт выполняется в среде Windows

#Область ПрограммныйИнтерфейс

// Функция - возвращает адрес страницы авторизации
//
// Возвращаемое значение:
//   Строка    - адрес страницы авторизации
//
Функция СервисАвторизации() Экспорт

	Возврат "https://login.1c.ru";

КонецФункции // СервисАвторизации()

// Функция - возвращает адрес сервиса релизов
//
// Возвращаемое значение:
//   Строка    - адрес сервиса релизов
//
Функция СервисРелизов() Экспорт

	Возврат "https://releases.1c.ru";

КонецФункции // СервисРелизов()

// Функция - возвращает относительный адрес страницы списка релизов
//
// Возвращаемое значение:
//   Строка    - относительный адрес страницы списка релизов
//
Функция СтраницаСпискаРелизов() Экспорт

	Возврат "total";

КонецФункции // СтраницаСпискаРелизов()

// Функция - возвращает шаблон строки регистрации
//
// Возвращаемое значение:
//   Строка    - шаблон строки регистрации
//
Функция ШаблонСтрокиРегистрации() Экспорт

	Возврат "inviteCode=&username=%1&password=%2&execution=%3"
	      + "&_eventId=submit&geolocation=&submit=Войти&rememberMe=on";

КонецФункции // ШаблонСтрокиРегистрации()

// Функция - возвращает шаблон поиска строки регистрации
//
// Возвращаемое значение:
//   Строка    - шаблон поиска строки регистрации
//
Функция ШаблонПоискаСтрокиРегистрации() Экспорт

	Возврат "<input type=""hidden"" name=""execution"" value=""(.*)""\/>"
	      + "<input type=""hidden"" name=""_eventId""";

КонецФункции // ШаблонПоискаСтрокиРегистрации()

// Функция - возвращает шаблон поиска строки версии конфигурации
//
// Возвращаемое значение:
//   Строка    - шаблон поиска строки версии конфигурации
//
Функция ШаблонПоискаСтрокКонфигураций() Экспорт

	Возврат "<tr(?:.|\s)*?>.*?<\/tr>";

КонецФункции // ШаблонПоискаСтрокКонфигураций()

// Функция - возвращает шаблон поиска конфигураций на странице списка
//
// Возвращаемое значение:
//   Строка    - шаблон поиска конфигураций на странице списка
//
Функция ШаблонПоискаКонфигураций() Экспорт

	Возврат "<td class=""nameColumn""><a href=""(.*)"">(.*)<\/a>.*"
	      + "<td class=""versionColumn actualVersionColumn"">"
	      + "<a href="".*nick=(.*)&ver=(\d(?:\d|\.)*)"">.*"
	      + "?<td class=""releaseDate"">.*?(\d(?:\d|\.)*)";

КонецФункции // ШаблонПоискаКонфигураций()

// Функция - возвращает шаблон поиска колонок со списком предварительных версий
//
// Возвращаемое значение:
//   Строка    - шаблон поиска колонок со списком предварительных версий
//
Функция ШаблонПоискаКолонокБетаВерсий() Экспорт

	Возврат "<td class=""versionColumn"">.*?<\/td><td class=""versionColumn"">(.*?)"
	      + "<td class=""publicationDate"">(.*?)<\/td>";

КонецФункции // ШаблонПоискаКолонокБетаВерсий()

// Функция - возвращает шаблон поиска ссылок на предварительные версии
//
// Возвращаемое значение:
//   Строка    - шаблон поиска ссылок на предварительные версии
//
Функция ШаблонПоискаСсылокБетаВерсий() Экспорт

	Возврат "<a href=""(.*?)"">(.*?)<\/a><br.*?>";

КонецФункции // ШаблонПоискаСсылокБетаВерсий()

// Функция - возвращает шаблон поиска дат предварительных версий
//
// Возвращаемое значение:
//   Строка    - шаблон поиска дат предварительных версий
//
Функция ШаблонПоискаДатБетаВерсий() Экспорт

	Возврат "(\d\d\.\d\d\.\d\d)+";

КонецФункции // ШаблонПоискаДатБетаВерсий()

// Функция - возвращает шаблон поиска версии приложения на странице списка версий
//
// Возвращаемое значение:
//   Строка    - шаблон поиска версии приложения на странице списка версий
//
Функция ШаблонПоискаВерсий() Экспорт

	Возврат "<td class=""versionColumn"">\s*<a href=""(.*)"">\s*(.*)\s*<\/a>(\s|.)*?"
	      + "<td class=""dateColumn"">\s*(.*)\s*<\/td>(\s|.)*?"
	      + "(?:<td class=""itsColumn"">\s*(?:.*)\s*<\/td>(?:\s|.)*?)?"
	      + "<td class=""version previousVersionsColumn"">\s*(.*)\s*<\/td>";

КонецФункции // ШаблонПоискаВерсий()

// Функция - возвращает шаблон поиска адреса страницы загрузки дистрибутива
//
// Возвращаемое значение:
//   Строка    - шаблон поиска адреса страницы загрузки дистрибутива
//
Функция ШаблонПоискаАдресаСтраницыЗагрузки() Экспорт

	Возврат "<div class=""formLine"">\s*<a href=""(.*)"">\s*(.*)\s*<\/a>(\s|.)*?<\/div>";

КонецФункции // ШаблонПоискаАдресаСтраницыЗагрузки()

// Функция - возвращает шаблон поиска ссылки для загрузки дистрибутива
//
// Возвращаемое значение:
//   Строка    - шаблон поиска ссылки для загрузки дистрибутива
//
Функция ШаблонПоискаСсылкиДляЗагрузки() Экспорт

	Возврат "<div class=""downloadDist"">(\s|.)*?<a href=""(.*)"">\s*"
            + "Скачать дистрибутив\s*<\/a>(\s|.)*?<\/div>";

КонецФункции // ШаблонПоискаСсылкиДляЗагрузки()

// Функция - возвращает шаблон поиска пути к файлу в ссылке для загрузки
//
// Возвращаемое значение:
//   Строка    - шаблон поиска пути к файлу в ссылке для загрузки
//
Функция ШаблонПоискаПутиКФайлуВАдресе() Экспорт

	Возврат "\?.*path=(.+)(?:\z|&)";

КонецФункции // ШаблонПоискаПутиКФайлуВАдресе()

Процедура Инициализация(Знач Параметры = Неопределено)

	ОбщиеПараметры = Новый Структура();

	Если ТипЗнч(Параметры) = Тип("Структура") Тогда
		Для Каждого ТекПараметр Из Параметры Цикл
			ОбщиеПараметры.Добавить(ТекПараметр.Ключ, ТекПараметр.Значение);
		КонецЦикла;
	КонецЕсли;

КонецПроцедуры // Инициализация()

// Функция - проверяет, что скрипт выполняется в среде Windows
//
// Возвращаемое значение:
//	Булево     - Истина - скрипт выполняется в среде Windows
//
Функция ЭтоWindows() Экспорт

	Если ЭтоWindows = Неопределено Тогда
		СистемнаяИнформация = Новый СистемнаяИнформация;
		ЭтоWindows = Найти(НРег(СистемнаяИнформация.ВерсияОС), "windows") > 0;
	КонецЕсли;

	Возврат ЭтоWindows;

КонецФункции // ЭтоWindows()

// Функция - проверяет, что выполняется скомпилированный скрипт
//
// Возвращаемое значение:
//	Булево     - Истина - выполняется скомпилированный скрипт
//
Функция ЭтоСборкаEXE() Экспорт
	
	Если ЭтоПриложениеEXE = Неопределено Тогда
		ЭтоПриложениеEXE = ВРег(Прав(ТекущийСценарий().Источник, 3)) = "EXE";
	КонецЕсли;

	Возврат ЭтоПриложениеEXE;

КонецФункции // ЭтоСборкаEXE()

// Функция - при необходтимости, определяет и возвращает текущий каталог приложения
//
// Возвращаемое значение:
//  Строка      - текущий каталог приложения
//
Функция КаталогПриложения() Экспорт
	
	Если Не СохрКаталогПриложения = Неопределено Тогда
		Возврат СохрКаталогПриложения;
	КонецЕсли;

	ПутьККаталогу = ОбъединитьПути(ТекущийСценарий().Каталог, "..", "..", "..");

	ФайлКаталога = Новый Файл(ПутьККаталогу);
	СохрКаталогПриложения = ФайлКаталога.ПолноеИмя;
	
	Возврат СохрКаталогПриложения;

КонецФункции // КаталогПриложения()

// Функция - возвращает текущий уровень лога приложения
//
// Возвращаемое значение:
//  Строка      - текущий уровень лога приложения
//
Функция УровеньЛога() Экспорт

	Возврат ЛогПриложения.Уровень();

КонецФункции // УровеньЛога()

// Процедура - включает режим отладки
//
// Параметры:
//	Булево     - Истина - включить режим отладки
//
Процедура УстановитьРежимОтладки(Знач РежимОтладки) Экспорт
	
	Если РежимОтладки Тогда
		
		Лог().УстановитьУровень(УровниЛога.Отладка);

	КонецЕсли;
	
КонецПроцедуры // УстановитьРежимОтладки()

// Функция - возвращает общие параметры приложения
//
// Возвращаемое значение:
//  Структура      - общие параметры приложения
//
Функция Параметры() Экспорт

	Возврат ОбщиеПараметры;

КонецФункции // Параметры()

// Функция - при необходимости, инициализирует и возвращает объект управления логированием
//
// Возвращаемое значение:
//  Объект      - объект управления логированием
//
Функция Лог() Экспорт
	
	Если ЛогПриложения = Неопределено Тогда
		ЛогПриложения = Логирование.ПолучитьЛог(ИмяЛогаПриложения());
	КонецЕсли;

	Возврат ЛогПриложения;

КонецФункции // Лог()

// Функция - возвращает имя лога приложения
//
// Возвращаемое значение:
//  Строка      - имя лога приложения
//
Функция ИмяЛогаПриложения() Экспорт

	Возврат "oscript.app." + ИмяПриложения();

КонецФункции // ИмяЛогаПриложения()

// Функция - возвращает имя приложения
//
// Возвращаемое значение:
//  Строка      - имя приложения
//
Функция ИмяПриложения() Экспорт

	Возврат "yard";
		
КонецФункции // ИмяПриложения()

// Функция - возвращает версию приложения
//
// Возвращаемое значение:
//  Строка      - версия приложения
//
Функция Версия() Экспорт
	
	Возврат "1.7.3";
	
КонецФункции // Версия()

#КонецОбласти // ПрограммныйИнтерфейс

Инициализация();
