CREATE TABLE "comments"(
                           "id" bigserial NOT NULL,
                           "comment_decription" varchar NOT NULL,
                           "user_id" BIGINT NOT NULL
);

ALTER TABLE
    "comments" ADD PRIMARY KEY("id");
CREATE TABLE "accaunt"(
                          "id" bigserial NOT NULL,
                          "user_id" BIGINT NOT NULL,
                          "post_id" BIGINT NOT NULL,
                          "nick_name" VARCHAR(255) NOT NULL,
                          "status" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "accaunt" ADD PRIMARY KEY("id");
CREATE TABLE "user"(
                       "id" bigserial NOT NULL,
                       "name" VARCHAR(255) NOT NULL,
                       "gender" VARCHAR(255) NOT NULL,
                       "age" BIGINT NOT NULL
);
ALTER TABLE
    "user" ADD PRIMARY KEY("id");
CREATE TABLE "post"(
                       "id" bigserial NOT NULL,
                       "comments_id" BIGINT NOT NULL,
                       "like_id" BIGINT NOT NULL,
                       "title" VARCHAR(255) NOT NULL,
                       "date" DATE NOT NULL
);

ALTER TABLE
    "post" ADD PRIMARY KEY("id");
CREATE TABLE "likes"(
                        "id" bigserial NOT NULL,
                        "like" CHAR(255) NOT NULL,
                        "user_id" BIGINT NOT NULL,
                        "date" DATE NOT NULL
);
ALTER TABLE
    "likes" ADD PRIMARY KEY("id");
ALTER TABLE
    "comments" ADD CONSTRAINT "comments_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "user"("id");
ALTER TABLE
    "post" ADD CONSTRAINT "post_like_id_foreign" FOREIGN KEY("like_id") REFERENCES "likes"("id");
ALTER TABLE
    "accaunt" ADD CONSTRAINT "accaunt_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "user"("id");
ALTER TABLE
    "post" ADD CONSTRAINT "post_id_foreign" FOREIGN KEY("id") REFERENCES "comments"("id");
ALTER TABLE
    "accaunt" ADD CONSTRAINT "accaunt_post_id_foreign" FOREIGN KEY("post_id") REFERENCES "post"("id");
ALTER TABLE
    "likes" ADD CONSTRAINT "likes_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "user"("id");

create or replace function searching_posts(
    i_title varchar
)
    returns table(
                     id bigint,
                     title varchar,
                     comment_id bigint,
                     like_id bigint
                 )
    language plpgsql
as
$$BEGIN
    return query select p.id ,p.title,p.comments_id,p.like_id from post p where p.title ilike i_title;
end;

$$;



insert into post (comments_id, like_id, title) VALUES (1,2,'phone',current_date);

insert into "user"(name, gender, age) values ('rose','female',19);
insert into likes("like", user_id) VALUES ('❤',1,current_date);
insert into comments(comment_decription, user_id) VALUES ('funny',1);
select *
from accaunt;
select * from post;
select * from comments;
select * from likes;


select searching_posts('phone');

create or replace procedure deleting_post(
in i_id bigint
)
language plpgsql
as
$$BEGIN
delete from post where id=i_id;
end;
$$;

call deleting_post(1);
select * from post;

create view returning_users_post as select name,comment_decription from "user" inner join comments c on "user".id = c.user_id where "user".id=1;



create materialized view statistics_of_post as select p.id,title,count(extract(year from date)=2023) as summary from post p 
                                               group by p.id, title;


