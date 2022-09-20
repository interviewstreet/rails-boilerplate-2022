create user dev with password 'password';
alter role dev superuser createrole createdb replication;
create database rails_boilerplate;
alter database rails_boilerplate owner to dev;