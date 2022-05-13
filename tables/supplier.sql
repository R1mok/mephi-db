create table supplier
(
    supplier_id integer default nextval('supplier_suplier_id_seq'::regclass) not null
        constraint supplier_pk
            primary key
        constraint supplier_supplier_id_check
            check (supplier_id > 0),
    name        varchar(100)                                                 not null
        constraint supplier_name_check
            check ((name)::text ~ similar_to_escape('[A-ZА-Я][a-zа-я0-9]{1,99}'::text))
);

alter table supplier
    owner to postgres;

create unique index supplier_name_uindex
    on supplier (name);

