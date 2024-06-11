import 'package:get/get.dart';

class LocaleString extends Translations{
  @override
  Map<String, Map<String, String>> get keys => {
    'ru_RU':{
      'Dilshodjon Haydarov':'Дильшоджон Хайдаров',
      'hello': 'Привет, мир',
      'message':'Добро пожаловать в Proto Coders Point',
      'title':'Язык Flutter - Локализация',
      'subscribe':'Подписывайтесь сейчас',
      'changelang':'Изменить язык',
      'f.i.sh':'Ф.И.О:',
      'Kiriting':'Введите',
      'Telefon raqam':'Номер телефона',
      'Parolni kiriting':'Введите пароль',
      'Parolni takrorlang':'Повторите пароль',
      'Ommaviy oferta':'Публичная оферта',
      'shartlariga roziman':'Я согласен с условиями',
      'Ro‘yxatdan o‘tish':'Регистрация',
      'Ro‘yxatdan o‘tganmisiz?':'Вы зарегистрированы?',
      'Kirish':'Вход',
      'Parol':'Пароль',
      'Eslab qolish':'Запомнить меня',
      'Parolni unutdingizmi?':'Забыли пароль?',
      'SMS kod' : 'SMS код',
      'SMS xabar kelmadimi?':'Не пришло SMS сообщение?',
      'Qayta yuborish' : 'Отправить повторно',
      'Tasdiqlash' : 'Подтвердить',
      'Parolni tiklash':'Сбросить пароль',
      'SMS kodni yuborish':'Отправить SMS код',
      'Filterlarni o‘chirish':'Фильтры',

      //validation
      'Xatolik':'Ошибка',
      'Bunday foydalanuvchi mavjud!':'Пользователь уже существует!',
      'Server bilan bog‘lanishda xatolik!':'Ошибка подключения к серверу!',
      'Parol kamida 6 ta belgidan iborat bo‘lishi kerak!':'Пароль должен содержать не менее 6 символов!',
      'f.i.sh kiriting!':'Введите Ф.И.О!',
      'Parolni takrorlangan qismi mos kelmadi!':'Повторная часть пароля не совпала!',
      'Telefon raqamni kiriting!':'Введите номер телефона!',
      'Parolni kiriting!':'Введите пароль!',
      'Parolni takrorlang!':'Повторите пароль!',
      'Parollar mos kelmadi!':'Пароли не совпали!',
      'Ommaviy oferta shartlariga rozilik bildirishingiz kerak!': 'Вы должны согласиться с условиями публичной оферты!',
      'SMS kodni kiriting!':'Введите SMS код!',
      'Muvaffaqiyatli' : 'Успешно',
      'Parolni muvaffaqiyatli o‘zgartirdingiz!':'Вы успешно изменили пароль!',
      'Bunday foydalanuvchi mavjud emas!':'Пользователь не найден!',
      'Noto‘g‘ri parol kiritdingiz!':'Вы ввели неправильный пароль!',
      'Ma‘lumotlar yo‘q!':'Нет данных!',
      'Internet aloqasi yo‘q':'Нет интернета',
      'Sotuvda mavjud': 'В наличии',
      'Sotuvda mavjud emas': 'Нет в наличии',
      'Ma‘lumotlar yangilandi':'Данные обновлены',
      'Davlatni tanlang!' : 'Выберите страну!',
      'Viloyatni tanlang!':'Выберите регион!',
      'Manzilni kiriting!':'Введите адрес!',

      //Sample page
      'Kitoblarni izlash':'Поиск книг',
      'Kategoriya':'Категория',
      'Barchasi':'Все',
      'Elektron kitoblar':'Электронные книги',
      'Asosiy':'Главный',
      'Do‘kon':'Магазин',
      'Kutubxona':'Библиотека',
      'Savatcha':'Корзина',
      'Sahifam':'Моя страница',
      'Audio kitoblar':'Аудиокниги',
      'Iqtiboslar':'Избранное',
      'Mualliflar':'Авторы',
      'Top':'Топ',
      'Kitoblar':'Книги',
      'Do‘kon mahsulotlari':'Товары магазина',
      'Sizni yuzlab jozibador hikoyalar kutmoqda':'Сотни захватывающих историй ждут вас',
      'Sevimli janrlaringizni o‘rganing':'Sevimli janrlaringizni o‘rganing',

      //Sahifam page
      'Profilni tahrirlash':'Редактировать профиль',
      'Mening kitoblarim':'Мои книги',
      'Buyurtmalar':'Заказы',
      'Buyurtma':'Заказ',
      'Chegirmalar':'Скидки',
      'Promokod':'Промокод',
      'Tilni o‘zgartirish':'Изменить язык',
      'O‘qish turi' : 'Тип чтения',
      'Tungi rejim':'Ночной режим',
      'Dastur haqida':'О программе',
      'Biz bilan bog‘lanish':'Связаться с нами',
      'Ilovadan chiqish':'Выйти из приложения',
      'Shaxsiy ma‘lumotlar':'Персональные данные',

      //detail page
      'ta kitob':'Книга',
      'ta izoh':'Комментарий',
      'ta ko‘rilgan':'Просмотрено',
      'Xarid':'Купить',
      'Izoh':'Комментарий',
      'Izohlar':'Комментарии',
      'Tafsilotlar':'Детали',
      'Tavsif':'Описание',
      'Sizning fikringiz':'Ваше мнение',
      'Jo‘natish':'Отправить',
      'Muallif':'Автор',
      'Qog‘ozli kitob':'Бумажная книга',
      'Elektron kitob':'Электронная книга',
      'Audio kitob':'Аудиокнига',
      'Baholang':'Оценка',
      'Mualif haqida':'Об авторе',
      'Tavsiya etiladi':'Рекомендуется',
      'Izohlar yo‘q':'Комментарии отсутствуют',
      'Tahrirlash':'Редактировать',
      'O‘chirish':'Удалить',
      'Saqlash':'Сохранить',
      'so‘m':'сум',
      'Xaridni boshlash' : 'Начать покупку',
      'Savatga mahsulotlarni qo‘shish uchun xarid qilishni boshlang.':'Добавить книги в корзину для оформления заказа.',
      'Savat bo‘sh':'Корзина пуста',
      'Savatga qo‘shish':'Добавить в корзину',
      'Yetkazib berish manzili':'Адрес доставки',
      'To‘lov turi':'Тип оплаты',
      'Buyurtmani tasdiqlash':'Подтвердить заказ',
      'Davlat':'Страна',
      'Tuman / shahar':'Район / город',
      'Manzil':'Адрес',
      'Davom etish':'Продолжить',
      'Orqaga':'Назад',
      'Mahsulotlar':'Товары',
      'Do‘kondan olib ketishingiz mumkin.':'Вы можете вернуться к магазину.',
      'Yetkazib berish narxi':'Стоимость доставки',
      'Buyurtma raqami':'Номер заказа',
      'Buyurtma sanasi':'Дата заказа',
      'To‘lov miqdori':'Количество оплаты',
      'dona':'шт',
      'Jami xizmatlar bilan':'Общая стоимость услуг',
      'Bu manzilga yetkazib berish narxi operator tomonidan xabar beriladi!':'Стоимость доставки определяется оператором!',
      'Yangi':'Новые',
      'Ko‘rib chiqilmoqda':'На рассмотрении',
      'To‘lov qabul qilindi':'Оплата подтверждена',
      'To‘lov qabul qilinmadi':'Оплата не подтверждена',
      'To‘lov qilishdagi xatolik':'Произошла ошибка при оплате',
      'Qaytarildi':'Возвращено',
      'Bekor qilindi':'Отменено',

    },
    'uz_UZ':{
      'Dilshodjon Haydarov':'Dilshodjon Haydarov',

      'hello': 'Salom Dunyo',
      'message':'Proto Coders Pointga xush kelibsiz',
      'title':'Flutter Tili - Lokallashtirish',
      'subscribe':'Hozir obuna bo‘ling',
      'changelang':'Tilni o‘zgartirish',
      'f.i.sh':'F.I.SH:',
      'Kiriting':'Kiriting',
      'Telefon raqam':'Telefon raqam',
      'Parolni kiriting':'Parolni kiriting',
      'Parolni takrorlang':'Parolni takrorlang',
      'Ommaviy oferta':'Ommaviy oferta',
      'shartlariga roziman':'shartlariga roziman',
      'Ro‘yxatdan o‘tish':'Ro‘yxatdan o‘tish',
      'Ro‘yxatdan o‘tganmisiz?':'Ro‘yxatdan o‘tganmisiz?',
      'Kirish':'Kirish',
      'Parol':'Parol',
      'Eslab qolish':'Eslab qolish',
      'Parolni unutdingizmi?':'Parolni unutdingizmi?',
      'SMS kod' : 'SMS kod',
      'SMS xabar kelmadimi?':'SMS xabar kelmadimi?',
      'Qayta yuborish' : 'Qayta yuborish',
      'Tasdiqlash' : 'Tasdiqlash',
      'Parolni tiklash':'Parolni tiklash',
      'SMS kodni yuborish':'SMS kodni yuborish',
      'Filterlarni o‘chirish':'Filterlarni o‘chirish',

      //validation
      'Xatolik':'Xatolik',
      'Bunday foydalanuvchi mavjud!':'Bunday foydalanuvchi mavjud!',
      'Server bilan bog‘lanishda xatolik!':'Server bilan bog‘lanishda xatolik!',
      'Parol kamida 6 ta belgidan iborat bo‘lishi kerak!':'Parol kamida 6 ta belgidan iborat bo‘lishi kerak!',
      'f.i.sh kiriting!':'f.i.sh kiriting!',
      'Parolni takrorlangan qismi mos kelmadi!':'Parolni takrorlangan qismi mos kelmadi!',
      'Telefon raqamni kiriting!':'Telefon raqamni kiriting!',
      'Parolni kiriting!':'Parolni kiriting!',
      'Parolni takrorlang!':'Parolni takrorlang!',
      'Parollar mos kelmadi!':'Parollar mos kelmadi!',
      'Ommaviy oferta shartlariga rozilik bildirishingiz kerak!': 'Ommaviy oferta shartlariga rozilik bildirishingiz kerak!',
      'SMS kodni kiriting!':'SMS kodni kiriting!',
      'Muvaffaqiyatli' : 'Muvaffaqiyatli',
      'Parolni muvaffaqiyatli o‘zgartirdingiz!':'Parolni muvaffaqiyatli o‘zgartirdingiz!',
      'Bunday foydalanuvchi mavjud emas!':'Bunday foydalanuvchi mavjud emas!',
      'Noto‘g‘ri parol kiritdingiz!':'Noto‘g‘ri parol kiritdingiz!',
      'Ma‘lumotlar yo‘q!':'Ma‘lumotlar yo‘q!',
      'Internet aloqasi yo‘q':'Internet aloqasi yo‘q',
      'Sotuvda mavjud': 'Sotuvda mavjud',
      'Sotuvda mavjud emas': 'Sotuvda mavjud emas',
      'Ma‘lumotlar yangilandi!':'Ma‘lumotlar yangilandi!',
      'Davlatni tanlang!': 'Davlatni tanlang!',
      'Viloyatni tanlang!':'Viloyatni tanlang!',
      'Manzilni kiriting!':'Manzilni kiriting!',

      //Sample page
      'Kitoblarni izlash':'Kitoblarni izlash',
      'Kategoriya':'Kategoriya',
      'Barchasi':'Barchasi',
      'Elektron kitoblar':'Elektron kitoblar',
      'Asosiy':'Asosiy',
      'Do‘kon':'Do‘kon',
      'Kutubxona':'Kutubxona',
      'Savatcha':'Savatcha',
      'Sahifam':'Sahifam',
      'Audio kitoblar':'Audio kitoblar',
      'Iqtiboslar':'Iqtiboslar',
      'Mualliflar':'Mualliflar',
      'Top':'Top',
      'Kitoblar':'Kitoblar',
      'Do‘kon mahsulotlari':'Do‘kon mahsulotlari',
      'Sizni yuzlab jozibador hikoyalar kutmoqda':'Sizni yuzlab jozibador hikoyalar kutmoqda',
      'Sevimli janrlaringizni o‘rganing':'Sevimli janrlaringizni o‘rganing',

      //Sahifam page
      'Profilni tahrirlash':'Profilni tahrirlash',
      'Mening kitoblarim':'Mening kitoblarim',
      'Buyurtmalar':'Buyurtmalar',
      'Buyurtma':'Buyurtma',
      'Chegirmalar':'Chegirmalar',
      'Promokod':'Promokod',
      'Tilni o‘zgartirish':'Tilni o‘zgartirish',
      'O‘qish turi' : 'O‘qish turi',
      'Tungi rejim':'Tungi rejim',
      'Dastur haqida':'Dastur haqida',
      'Biz bilan bog‘lanish':'Biz bilan bog‘lanish',
      'Ilovadan chiqish':'Ilovadan chiqish',
      'Shaxsiy ma‘lumotlar':'Shaxsiy ma‘lumotlar',

      //detail page
      'ta kitob':'ta kitob',
      'ta izoh':'ta izoh',
      'ta ko‘rilgan':'ta ko‘rilgan',
      'Xarid':'Xarid',
      'Izoh':'Izoh',
      'Izohlar':'Izohlar',
      'Tafsilotlar':'Tafsilotlar',
      'Tavsif':'Tavsif',
      'Sizning fikringiz':'Sizning fikringiz',
      'Jo‘natish':'Jo‘natish',
      'Muallif':'Muallif',
      'Qog‘ozli kitob':'Qog‘ozli kitob',
      'Elektron kitob':'Elektron kitob',
      'Audio kitob':'Audio kitob',
      'Baholang':'Baholang',
      'Mualif haqida':'Mualif haqida',
      'Tavsiya etiladi':'Tavsiya etiladi',
      'Izohlar yo‘q':'Izohlar yo‘q',
      'Tahrirlash':'Tahrirlash',
      'O‘chirish':'O‘chirish',
      'Saqlash':'Saqlash',
      'so‘m':'so‘m',
      'Xaridni boshlash':'Xaridni boshlash',
      'Savatga mahsulotlarni qo‘shish uchun xarid qilishni boshlang.':'Savatga mahsulotlarni qo‘shish uchun xarid qilishni boshlang.',
      'Savat bo‘sh':'Savat bo‘sh',
      'Savatga qo‘shish':'Savatga qo‘shish',
      'Yetkazib berish manzili':'Yetkazib berish manzili',
      'To‘lov turi':'To‘lov turi',
      'Buyurtmani tasdiqlash':'Buyurtmani tasdiqlash',
      'Davlat':'Davlat',
      'Tuman / shahar':'Tuman / shahar',
      'Manzil':'Manzil',
      'Davom etish':'Davom etish',
      'Orqaga':'Orqaga',
      'Mahsulotlar':'Mahsulotlar',
      'Do‘kondan olib ketishingiz mumkin.':'Do‘kondan olib ketishingiz mumkin.',
      'Yetkazib berish narxi':'Yetkazib berish narxi',
      'Buyurtma raqami':'Buyurtma raqami',
      'Buyurtma sanasi':'Buyurtma sanasi',
      'To‘lov miqdori':'To‘lov miqdori',
      'dona':'dona',
      'Jami xizmatlar bilan':'Jami xizmatlar bilan',
      'Bu manzilga yetkazib berish narxi operator tomonidan xabar beriladi!':'Bu manzilga yetkazib berish narxi operator tomonidan xabar beriladi!',
      'Yangi':'Yangi',
      'Ko‘rib chiqilmoqda':'Ko‘rib chiqilmoqda',
      'To‘lov qabul qilindi':'To‘lov qabul qilindi',
      'To‘lov qabul qilinmadi':'To‘lov qabul qilinmadi',
      'To‘lov qilishdagi xatolik':'To‘lov qilishdagi xatolik',
      'Qaytarildi':'Qaytarildi',
      'Bekor qilindi':'Bekor qilindi',

    },
    'oz_OZ':{
      'Dilshodjon Haydarov':'Дильшоджон Хайдаров',
      'hello': 'Салом Дунё',
      'message':'Прото Кодерс Пойнтга хуш келибсиз',
      'title':'Флуттер Тили - Локаллаштириш',
      'subscribe':'Ҳозир обуна бўлинг',
      'changelang':'Тилни ўзгартириш',
      'f.i.sh':'Ф.И.Ш:',
      'Kiriting':'Киритинг',
      'Telefon raqam':'Телефон рақам',
      'Parolni kiriting':'Паролни киритинг',
      'Parolni takrorlang':'Паролни тақрорланг',
      'Ommaviy oferta':'Оммавий оферта',
      'shartlariga roziman':'шартларига розиман',
      'Ro‘yxatdan o‘tish':'Рўйхатдан ўтиш',
      'Ro‘yxatdan o‘tganmisiz?':'Рўйхатдан ўтганмисиз?',
      'Kirish':'Кириш',
      'Parol':'Парол',
      'Eslab qolish':'Еслаб қолиш',
      'Parolni unutdingizmi?':'Паролни унутдингизми?',
      'SMS kod' : 'SMS код',
      'SMS xabar kelmadimi?':'SMS хабар келмадими?',
      'Qayta yuborish' : 'Қайта юбориш',
      'Tasdiqlash' : 'Тасдиқлаш',
      'Parolni tiklash':'Паролни тиклаш',
      'SMS kodni yuborish':'SMS кодни юбориш',
      'Filterlarni o‘chirish':'Филтерларни ўчириш',

      //validation
      'Xatolik':'Хатолик',
      'Bunday foydalanuvchi mavjud!':'Бундай фойдаланувчи мавжуд!',
      'Server bilan bog‘lanishda xatolik!':'Сервер билан боғланишда хатолик!',
      'Parol kamida 6 ta belgidan iborat bo‘lishi kerak!':'Парол камида 6 та белгидан иборат бўлиши керак!',
      'f.i.sh kiriting!':'Ф.И.Ш киритинг!',
      'Parolni takrorlangan qismi mos kelmadi!':'Паролни тақрорланган қисми мос келмади!',
      'Telefon raqamni kiriting!':'Телефон рақамни киритинг!',
      'Parolni kiriting!':'Паролни киритинг!',
      'Parolni takrorlang!':'Паролни тақрорланг!',
      'Parollar mos kelmadi!':'Пароллар мос келмади!',
      'Ommaviy oferta shartlariga rozilik bildirishingiz kerak!': 'Оммавий оферта шартларига розилик билдиришингиз керак!',
      'SMS kodni kiriting!':'SMS кодни киритинг!',
      'Muvaffaqiyatli' : 'Муваффақиятли',
      'Parolni muvaffaqiyatli o‘zgartirdingiz!':'Паролни муваффақиятли ўзгартирдингиз!',
      'Bunday foydalanuvchi mavjud emas!':'Бундай фойдаланувчи мавжуд емас!',
      'Noto‘g‘ri parol kiritdingiz!':'Ното‘г‘ри парол киритдингиз!',
      'Ma‘lumotlar yo‘q!':'Маълумотлар йўқ!',
      'Internet aloqasi yo‘q': 'Интернет алоқаси йўқ',
      'Sotuvda mavjud': 'Сотувда мавжуд',
      'Sotuvda mavjud emas': 'Сотувда мавжуд емас',
      'Ma‘lumotlar yangilandi':'Маълумотлар ўзгартирилди',
      'Davlatni tanlang!':'Давлатни танланг!',
      'Viloyatni tanlang!':'Вилоятни танланг!',
      'Manzilni kiriting!':'Манзилни киритинг!',

      //Sample page
      'Kitoblarni izlash':'Китобларни излаш',
      'Kategoriya':'Категория',
      'Barchasi':'Барчаси',
      'Elektron kitoblar':'Электрон китоблар',
      'Asosiy':'Асосий',
      'Do‘kon':'Дўкон',
      'Kutubxona':'Кутубхона',
      'Savatcha':'Саватча',
      'Sahifam':'Саҳифам',
      'Audio kitoblar':'Аудио китоблар',
      'Iqtiboslar':'Иқтибослар',
      'Mualliflar':'Муаллифлар',
      'Top':'Топ',
      'Kitoblar':'Китоблар',
      'Do‘kon mahsulotlari':'Дўкон маҳсулотлари',
      'Sizni yuzlab jozibador hikoyalar kutmoqda':'Сизни юзлаб жозибадор ҳикоялар кутмоқда',
      'Sevimli janrlaringizni o‘rganing':'Севимли жанрларингизни ўрганинг',

      //Sahifam page
      'Profilni tahrirlash':'Профилни таҳрирлаш',
      'Mening kitoblarim':'Менинг китобларим',
      'Buyurtmalar':'Буюртмалар',
      'Buyurtma':'Буюртма',
      'Chegirmalar':'Чегирмалар',
      'Promokod':'Промокод',
      'Tilni o‘zgartirish':'Тилни ўзгартириш',
      'O‘qish turi' : 'Ўқиш тури',
      'Tungi rejim':'Тунги режим',
      'Dastur haqida':'Дастур ҳақида',
      'Biz bilan bog‘lanish':'Биз билан боғланиш',
      'Ilovadan chiqish':'Иловадан чиқиш',
      'Shaxsiy ma‘lumotlar':'Шахсий маълумотлар',

      //detail page
      'ta kitob':'та китоб',
      'ta izoh':'та изоҳ',
      'ta ko‘rilgan':'та кўрилган',
      'Xarid':'Харид',
      'Izoh':'Изоҳ',
      'Izohlar':'Изоҳлар',
      'Tafsilotlar':'Тафсилотлар',
      'Tavsif':'Тавсиф',
      'Sizning fikringiz':'Сизнинг фикрингиз',
      'Jo‘natish':'Жўнатиш',
      'Muallif':'Муаллиф',
      'Qog‘ozli kitob':'Қоғозли китоб',
      'Elektron kitob':'Электрон китоб',
      'Audio kitob':'Аудио китоб',
      'Baholang':'Баҳоланг',
      'Mualif haqida':'Муаллиф ҳақида',
      'Tavsiya etiladi':'Тавсия этилади',
      'Izohlar yo‘q':'Изоҳлар йўқ',
      'Tahrirlash':'Таҳрирлаш',
      'O‘chirish':'Очириш',
      'Saqlash':'Сақлаш',
      'so‘m':'сўм',
      'Xaridni boshlash':'Харидни бошлаш',
      'Savatga mahsulotlarni qo‘shish uchun xarid qilishni boshlang.':'Саватга маҳсулотларни қўшиш учун харид қилишни бошланг.',
      'Savat bo‘sh':'Сават бўш',
      'Savatga qo‘shish':'Саватга қўшиш',
      'Yetkazib berish manzili':'Етказиб бериш манзили',
      'To‘lov turi':'Тўлов тури',
      'Buyurtmani tasdiqlash':'Буюртмани тасдиқлаш',
      'Davlat':'Давлат',
      'Tuman / shahar':'Туман / шаҳар',
      'Manzil':'Манзил',
      'Davom etish':'Давом этиш',
      'Orqaga':'Орқага',
      'Mahsulotlar':'Маҳсулотлар',
      'Do‘kondan olib ketishingiz mumkin.':'Дўкондан олиб кетишингиз мумкин.',
      'Yetkazib berish narxi':'Етказиб бериш нархи',
      'Buyurtma raqami':'Буюртма рақами',
      'Buyurtma sanasi':'Буюртма санаси',
      'To‘lov miqdori':'Тўлов миқдори',
      'dona':'дона',
      'Jami xizmatlar bilan':'Жами хизматлар билан',
      'Bu manzilga yetkazib berish narxi operator tomonidan xabar beriladi!':'Бу манзилга етказиб бериш нархи оператор томонидан хабар берилади!',
      'Yangi':'Янги',
      'Ko‘rib chiqilmoqda':'Кўриб чиқилмоқда',
      'To‘lov qabul qilindi':'Тўлов қабул қилинди',
      'To‘lov qabul qilinmadi':'Тўлов қабул қилинмади',
      'To‘lov qilishdagi xatolik':'Тўлов қилишдаги хатолик',
      'Qaytarildi':'Қайтарилди',
      'Bekor qilindi':'Бекор қилинди',

    }
  };

}