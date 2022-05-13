create table clothes_in_set
(
    set_id          integer not null
        constraint clothes_in_set_set_set_id_fk
            references set
            on update cascade on delete restrict
        constraint clothes_in_set_set_id_check
            check (set_id > 0),
    clothes_id      integer not null
        constraint clothes_in_set_clothes_clothes_id_fk
            references clothes
            on update cascade on delete restrict
        constraint clothes_in_set_clothes_id_check
            check (clothes_id > 0),
    quantity_in_set integer
        constraint clothes_in_set_quantity_in_set_check
            check (quantity_in_set >= 0),
    constraint clothes_in_set_pk
        primary key (set_id, clothes_id)
);

alter table clothes_in_set
    owner to postgres;
