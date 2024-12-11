create table university_info
(
    student_id   varchar(10),
    student_name varchar(200),
    address      varchar(200),
    course_code  varchar(10),
    course_name  varchar(200),
    instructor   varchar(200),
    department   varchar(200),
    grade        varchar(2)
);

insert into university_info (student_id, student_name, address, course_code, course_name, instructor, department, grade)
VALUES ('20BD202020', 'John John', 'Almaty, Tole bi 59', 'IT2020', 'Databases', 'Bob', 'IT', 'A'),
       ('20BD202020', 'John John', 'Almaty, Tole bi 59', 'IT2021', 'OOP', 'Bob2', 'IT', 'A-'),
       ('20BD202020', 'John John', 'Almaty, Tole bi 59', 'IT2022', 'PP', 'Bob3', 'IT', 'A');


-- 1NF - no duplicates, atomic columns and primary key
create table university_info
(
    student_id   varchar(10),
    student_name varchar(200), -- firstname, lastname
    city         varchar(200),
    street       varchar(200),
    course_code  varchar(10),
    course_name  varchar(200),
    instructor   varchar(200),
    department   varchar(200),
    grade        varchar(2),
    primary key (student_id, course_code)
);


--2NF - must be in 1NF and no partial dependency

create table student
(
    student_id   varchar(10) primary key,
    student_name varchar(200), -- firstname, lastname
    city         varchar(200),
    street       varchar(200)
);

create table course
(
    course_code varchar(10) primary key,
    course_name varchar(200),
    instructor  varchar(200),
    department  varchar(200)
);

create table enrollment
(
    student_id  varchar(10) references student,
    course_code varchar(10) references course,
    grade       varchar(2),
    primary key (student_id, course_code)
);


--3NF - must 2 NF and no transitive dependency


create table student
(
    student_id   varchar(10) primary key,
    student_name varchar(200), -- firstname, lastname
    street_id    integer references street
);

create table city
(
    id   serial primary key,
    name varchar(200)
);

create table street
(
    id      serial primary key,
    name    varchar(200),
    city_id integer references city
);

create table course
(
    course_code   varchar(10) primary key,
    course_name   varchar(200),
    instructor_id integer references instructor,
    department    varchar(200)
);


create table instructor
(
    id            serial primary key,
    name          varchar(200),
    department_id integer references department
);

create table department
(
    id   serial primary key,
    name varchar(200)
);

create table enrollment
(
    student_id  varchar(10) references student,
    course_code varchar(10) references course,
    grade       varchar(2),
    primary key (student_id, course_code)
);



create table category
(
    id        serial primary key,
    name      varchar(200),
    parent_id integer references category
);


create table product
(
    id          serial primary key,
    name        varchar(200),
    price       integer,
    category_id integer references category
);


create table attributes
(
    id          serial primary key,
    name        varchar(200),
    category_id integer references category
);


create table attr_value
(
    id      serial primary key,
    value   varchar(200),
    attr_id integer references attributes
);


create table product_attr_value
(
    product_id    integer references product,
    attr_value_id integer references attr_value,
    primary key (product_id, attr_value_id)
);



select *
from product p
         join product_attr_value pav on p.id = pav.product_id
         join attr_value av on pav.attr_value_id = av.id
         join attributes a on a.id = av.attr_id
where a.name = 'Бренд'
  and av.value = 'Apple';



create table product
(
    id          serial primary key,
    name        varchar(200),
    price       integer,
    attributes  jsonb,
    category_id integer references category
);


--
-- [
--     {
--         "key": "Brand",
--         "value": "Apple"
--     },
--     {
--         "key": "Model",
--         "value": "Iphone"
--     }
-- ]


-- {
--     "brand": {
--         "value":Apple",
--         "name": "Бренд"
--     },
--     "model": "Iphone"   
-- }


insert into product (name, price, attributes)
values ('Микроволновая печь Zigmund & Shtain BMO 18.172 X бежевая', 100000, '{
  "gril": {
    "name": {
      "kz": "Гриль",
      "ru": "Гриль"
    },
    "value": {
      "kz": "нетнет",
      "ru": "нетнет"
    },
    "is_main": false,
    "value_code": "netnet",
    "is_tech_spec": true
  },
  "brend": {
    "name": {
      "kz": "Бренд",
      "ru": "Бренд"
    },
    "value": {
      "kz": "Zigmund & ShtainZigmund & Shtain",
      "ru": "Zigmund & ShtainZigmund & Shtain"
    },
    "is_main": false,
    "value_code": "zigmund__shtainzigmund__shtain",
    "is_tech_spec": true
  },
  "tsvet": {
    "name": {
      "kz": "Цвет",
      "ru": "Цвет"
    },
    "value": {
      "kz": "бежевыйбежевый",
      "ru": "бежевыйбежевый"
    },
    "is_main": false,
    "value_code": "bezhevyjbezhevyj",
    "is_tech_spec": true
  },
  "obem_l": {
    "name": {
      "kz": "Объем, л",
      "ru": "Объем, л"
    },
    "value": {
      "kz": "18.000018.0000",
      "ru": "18.000018.0000"
    },
    "is_main": false,
    "value_code": "180000180000",
    "is_tech_spec": true
  },
  "dvertsa": {
    "name": {
      "kz": "Дверца",
      "ru": "Дверца"
    },
    "value": {
      "kz": "открывается кнопкойоткрывается кнопкой",
      "ru": "открывается кнопкойоткрывается кнопкой"
    },
    "is_main": false,
    "value_code": "otkryvaetsja_knopkojotkryvaetsja_knopkoj",
    "is_tech_spec": true
  },
  "programmy": {
    "name": {
      "kz": "Программы",
      "ru": "Программы"
    },
    "value": {
      "kz": "режим разморозкирежим разморозки",
      "ru": "режим разморозкирежим разморозки"
    },
    "is_main": false,
    "value_code": "rezhim_razmorozkirezhim_razmorozki",
    "is_tech_spec": true
  },
  "tajmer_min": {
    "name": {
      "kz": "Таймер, мин",
      "ru": "Таймер, мин"
    },
    "value": {
      "kz": "60.000060.0000",
      "ru": "60.000060.0000"
    },
    "is_main": false,
    "value_code": "600000600000",
    "is_tech_spec": true
  },
  "osobennosti": {
    "name": {
      "kz": "Особенности",
      "ru": "Особенности"
    },
    "value": {
      "kz": "Звуковой сигнал отключенияЗвуковой сигнал отключения",
      "ru": "Звуковой сигнал отключенияЗвуковой сигнал отключения"
    },
    "is_main": false,
    "value_code": "zvukovoj_signal_otkljuchenijazvukovoj_signal_otkljuchenija",
    "is_tech_spec": true
  },
  "raspolozhenie": {
    "name": {
      "kz": "Расположение",
      "ru": "Расположение"
    },
    "value": {
      "kz": "встраиваемаявстраиваемая",
      "ru": "встраиваемаявстраиваемая"
    },
    "is_main": false,
    "value_code": "vstraivaemajavstraivaemaja",
    "is_tech_spec": true
  },
  "tip_upravlenija": {
    "name": {
      "kz": "Тип управления",
      "ru": "Тип управления"
    },
    "value": {
      "kz": "механическое механическое ",
      "ru": "механическое механическое "
    },
    "is_main": false,
    "value_code": "mehanicheskoe_mehanicheskoe_",
    "is_tech_spec": true
  },
  "diametr_poddona_mm": {
    "name": {
      "kz": "Диаметр поддона, мм",
      "ru": "Диаметр поддона, мм"
    },
    "value": {
      "kz": "24.500024.5000",
      "ru": "24.500024.5000"
    },
    "is_main": false,
    "value_code": "245000245000",
    "is_tech_spec": true
  },
  "tip_perekljuchatelej": {
    "name": {
      "kz": "Тип переключателей",
      "ru": "Тип переключателей"
    },
    "value": {
      "kz": "поворотныеповоротные",
      "ru": "поворотныеповоротные"
    },
    "is_main": false,
    "value_code": "povorotnyepovorotnye",
    "is_tech_spec": true
  },
  "_bez_povorotnogo_stola": {
    "name": {
      "kz": "Без поворотного стола",
      "ru": " Без поворотного стола"
    },
    "value": {
      "kz": "нетнет",
      "ru": "нетнет"
    },
    "is_main": false,
    "value_code": "netnet",
    "is_tech_spec": true
  },
  "moschnost_mikrovoln_vt": {
    "name": {
      "kz": "Мощность микроволн, Вт",
      "ru": "Мощность микроволн, Вт"
    },
    "value": {
      "kz": "800.0000800.0000",
      "ru": "800.0000800.0000"
    },
    "is_main": false,
    "value_code": "80000008000000",
    "is_tech_spec": true
  },
  "strana_proishozhdenija": {
    "name": {
      "kz": "Страна происхождения",
      "ru": "Страна происхождения"
    },
    "value": {
      "kz": "ПортугалияПортугалия",
      "ru": "ПортугалияПортугалия"
    },
    "is_main": false,
    "value_code": "portugalijaportugalija",
    "is_tech_spec": true
  },
  "vnutrennee_pokrytie_kamery": {
    "name": {
      "kz": "Внутреннее покрытие камеры",
      "ru": "Внутреннее покрытие камеры"
    },
    "value": {
      "kz": "нержавеющая стальнержавеющая сталь",
      "ru": "нержавеющая стальнержавеющая сталь"
    },
    "is_main": false,
    "value_code": "nerzhavejuschaja_stalnerzhavejuschaja_stal",
    "is_tech_spec": true
  },
  "kolichestvo_urovnej_moschnosti_": {
    "name": {
      "kz": "Количество уровней мощности",
      "ru": "Количество уровней мощности "
    },
    "value": {
      "kz": "3.00003.0000",
      "ru": "3.00003.0000"
    },
    "is_main": false,
    "value_code": "3000030000",
    "is_tech_spec": true
  }
}');


insert into product (name, price, attributes)
values ('Набор инструментов Волат 19030-72 72 предмета', 120000, '{
  "tip": {
    "name": {
      "kz": "Тип",
      "ru": "Тип"
    },
    "value": {
      "kz": "набор инструментов и оснастки",
      "ru": "набор инструментов и оснастки"
    },
    "is_main": true,
    "value_code": "nabor_instrumentov_i_osnastki"
  },
  "brend": {
    "name": {
      "kz": "Бренд",
      "ru": "Бренд"
    },
    "value": {
      "kz": "Волат",
      "ru": "Волат"
    },
    "is_main": true,
    "value_code": "volat"
  },
  "naznachenie": {
    "name": {
      "kz": "Назначение",
      "ru": "Назначение"
    },
    "value": {
      "kz": "универсальный",
      "ru": "универсальный"
    },
    "is_main": true,
    "value_code": "universalnyj"
  },
  "shlitsy_bit": {
    "name": {
      "kz": "Шлицы бит",
      "ru": "Шлицы бит"
    },
    "value": {
      "kz": "крестообразный (PH), прямой (SL), Torx (T/TX)",
      "ru": "крестообразный (PH), прямой (SL), Torx (T/TX)"
    },
    "is_main": true,
    "value_code": "krestoobraznyj_ph_prjamoj_sl_torx_ttx"
  },
  "tip_golovok": {
    "name": {
      "kz": "Тип головок",
      "ru": "Тип головок"
    },
    "value": {
      "kz": "торцевые, удлиненные",
      "ru": "торцевые, удлиненные"
    },
    "is_main": true,
    "value_code": "tortsevye_udlinennye"
  },
  "bity_podrobno": {
    "name": {
      "kz": "Биты подробно",
      "ru": "Биты подробно"
    },
    "value": {
      "kz": "1/4\": SL3, SL4, SL5, SL6, PH1, PH2, PH3, T10, T15, T20, T25, T27, T30, T40",
      "ru": "1/4\": SL3, SL4, SL5, SL6, PH1, PH2, PH3, T10, T15, T20, T25, T27, T30, T40"
    },
    "is_main": true,
    "value_code": "14_sl3_sl4_sl5_sl6_ph1_ph2_ph3_t10_t15_t20_t25_t27_t30_t40"
  },
  "kolichestvo_bit": {
    "name": {
      "kz": "Количество бит",
      "ru": "Количество бит"
    },
    "value": {
      "kz": "14",
      "ru": "14"
    },
    "is_main": true,
    "value_code": "14"
  },
  "posadka_golovok": {
    "name": {
      "kz": "Посадка головок",
      "ru": "Посадка головок"
    },
    "value": {
      "kz": "1/4, 1/2",
      "ru": "1/4, 1/2"
    },
    "is_main": true,
    "value_code": "14_12"
  },
  "shlitsy_otvertok": {
    "name": {
      "kz": "Шлицы отвёрток",
      "ru": "Шлицы отвёрток"
    },
    "value": {
      "kz": "крестообразный (PH), прямой (SL)",
      "ru": "крестообразный (PH), прямой (SL)"
    },
    "is_main": true,
    "value_code": "krestoobraznyj_ph_prjamoj_sl"
  },
  "otvertki_podrobno": {
    "name": {
      "kz": "Отвертки подробно",
      "ru": "Отвертки подробно"
    },
    "value": {
      "kz": "PH2x38, PH2x100, PH3x150, SL6x38, SL6x100, SL8x200",
      "ru": "PH2x38, PH2x100, PH3x150, SL6x38, SL6x100, SL8x200"
    },
    "is_main": true,
    "value_code": "ph2x38_ph2x100_ph3x150_sl6x38_sl6x100_sl8x200"
  },
  "nakonechnik_golovok": {
    "name": {
      "kz": "Наконечник головок",
      "ru": "Наконечник головок"
    },
    "value": {
      "kz": "6-гранный",
      "ru": "6-гранный"
    },
    "is_main": true,
    "value_code": "6grannyj"
  },
  "kolichestvo_otvertok": {
    "name": {
      "kz": "Количество отверток",
      "ru": "Количество отверток"
    },
    "value": {
      "kz": "6",
      "ru": "6"
    },
    "is_main": true,
    "value_code": "6"
  },
  "osnastka_v_komplekte": {
    "name": {
      "kz": "Оснастка в комплекте",
      "ru": "Оснастка в комплекте"
    },
    "value": {
      "kz": "торцевые головки, биты",
      "ru": "торцевые головки, биты"
    },
    "is_main": true,
    "value_code": "tortsevye_golovki_bity"
  },
  "kolichestvo_predmetov": {
    "name": {
      "kz": "Количество предметов",
      "ru": "Количество предметов"
    },
    "value": {
      "kz": "72",
      "ru": "72"
    },
    "is_main": true,
    "value_code": "72"
  },
  "aksessuary_v_komplekte": {
    "name": {
      "kz": "Аксессуары в комплекте",
      "ru": "Аксессуары в комплекте"
    },
    "value": {
      "kz": "шарнир карданный для головок, кейс, удлинитель для головок",
      "ru": "шарнир карданный для головок, кейс, удлинитель для головок"
    },
    "is_main": true,
    "value_code": "sharnir_kardannyj_dlja_golovok_kejs_udlinitel_dlja_golovok"
  },
  "instrumenty_v_komplekte": {
    "name": {
      "kz": "Инструменты в комплекте",
      "ru": "Инструменты в комплекте"
    },
    "value": {
      "kz": "ключи имбусовые (шестигранные), ключи гаечные, ключ переставной гаечный, отвёртки, пассатижи, молоток, рукоять для бит, трещотка",
      "ru": "ключи имбусовые (шестигранные), ключи гаечные, ключ переставной гаечный, отвёртки, пассатижи, молоток, рукоять для бит, трещотка"
    },
    "is_main": true,
    "value_code": "kljuchi_imbusovye_shestigrannye_kljuchi_gaechnye_kljuch_perestavnoj_gaechnyj_otvertki_passatizhi_molotok_rukojat_dlja_bit_treschotka"
  },
  "gaechnye_kljuchi_podrobno": {
    "name": {
      "kz": "Гаечные ключи подробно",
      "ru": "Гаечные ключи подробно"
    },
    "value": {
      "kz": "ключи комбинированные: 10, 11, 12, 13, 14, 15, 17, 19 мм",
      "ru": "ключи комбинированные: 10, 11, 12, 13, 14, 15, 17, 19 мм"
    },
    "is_main": true,
    "value_code": "kljuchi_kombinirovannye_10_11_12_13_14_15_17_19_mm"
  },
  "golovki_tortsevye_podrobno": {
    "name": {
      "kz": "Головки торцевые подробно",
      "ru": "Головки торцевые подробно"
    },
    "value": {
      "kz": "4-32 мм",
      "ru": "4-32 мм"
    },
    "is_main": true,
    "value_code": "432_mm"
  },
  "dopolnitelnaja_informatsija": {
    "name": {
      "kz": "Дополнительная информация",
      "ru": "Дополнительная информация"
    },
    "value": {
      "kz": "шестигранные ключи: 1.5, 2, 3 мм",
      "ru": "шестигранные ключи: 1.5, 2, 3 мм"
    },
    "is_main": true,
    "value_code": "shestigrannye_kljuchi_15_2_3_mm"
  },
  "kolichestvo_gaechnyh_kljuchej": {
    "name": {
      "kz": "Количество гаечных ключей",
      "ru": "Количество гаечных ключей"
    },
    "value": {
      "kz": "8",
      "ru": "8"
    },
    "is_main": true,
    "value_code": "8"
  },
  "kolichestvo_tortsevyh_golovok": {
    "name": {
      "kz": "Количество торцевых головок",
      "ru": "Количество торцевых головок"
    },
    "value": {
      "kz": "25",
      "ru": "25"
    },
    "is_main": true,
    "value_code": "25"
  },
  "sharnirnogubtsevyj_instrument_razmery": {
    "name": {
      "kz": "Шарнирно-губцевый инструмент размеры",
      "ru": "Шарнирно-губцевый инструмент размеры"
    },
    "value": {
      "kz": "клещи переставные 250 мм, пассатижи 150 мм",
      "ru": "клещи переставные 250 мм, пассатижи 150 мм"
    },
    "is_main": true,
    "value_code": "kleschi_perestavnye_250_mm_passatizhi_150_mm"
  }
}');


select attributes -> 'brend' -> 'name'
from product;


select *
from product
where attributes -> 'brend' -> 'value' ->> 'kz' = 'Волат';

select attributes @> '{"brend": {"value": {"kz": "Волат"}}}'
from product;

select *
from product
where attributes @> '{"brend": {"value": {"kz": "Волат"}}}';

create index attr_index on product using gin (attributes);