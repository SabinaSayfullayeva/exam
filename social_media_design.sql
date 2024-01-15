
/*

Sayfullayeva Sabina
variant 2
https://drawsql.app/teams/myteam-755/diagrams/social-media
*/
CREATE TABLE "comments"(
    "id" bigserial NOT NULL,
    "comment_decription" VARCHAR(255) NOT NULL,
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