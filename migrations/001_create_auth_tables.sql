create extension if not exists "pgcrypto";

create table if not exists users(
	id UUID primary key default gen_random_uuid(),
	name TEXT,
	email TEXT not null unique,
	password_hash TEXT not null,
	is_active BOOLEAN not null default true,
	is_email_verified BOOLEAN not null default false,
	created_at timestamp with TIME zone default now(),
	updated_at timestamp with TIME zone default NOW()
);


create table if not exists auth_tokens(
	id UUID primary key default gen_random_uuid(),
	user_id UUID not null references users(id) on delete cascade,
	token TEXT not null,
	token_type TEXT not null default 'refresh',
	expires_at timestamp with TIME zone,
	created_at TIMESTAMP with TIME zone default now()
);


create table  if not exists password_resets(
	id UUID primary key DEFAULT gen_random_uuid(),
	user_id UUID not null references users(id) on delete cascade,
	reset_code TEXT not null,
	expires_at timestamp with TIME zone not null,
	used BOOLEAN not null default false,
	created_at TIMESTAMP with TIME zone default now()
);

create index if not exists idx_users_email on users(email);
create index if not exists idx_auth_tokens_user on auth_tokens(user_id);

