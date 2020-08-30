CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE base_table (
    create_at timestamp NOT NULL,
    updated_at timestamp NOT NULL
);

CREATE TABLE user_account (
    id uuid PRIMARY KEY DEFAULT uuid_generate_v1 (),
    email varchar(255) UNIQUE NOT NULL,
    password_hash varchar(255) NOT NULL
)
INHERITS (
    base_table
);

CREATE TABLE item (
    id uuid PRIMARY KEY DEFAULT uuid_generate_v1 (),
    title varchar(255) NOT NULL,
    notes text,
    seller_id uuid,
    price_in_cents integer, 
    foreign KEY (seller_id) REFERENCES user_account (id) ON DELETE CASCADE
   
)
INHERITS (
    base_table
);

CREATE TABLE purchase (
    id uuid PRIMARY KEY DEFAULT uuid_generate_v1 (),
    buyer_id uuid,
    item_id uuid,
    price_in_cents integer,
    title varchar(255) NOT NULL,
    foreign KEY (buyer_id) REFERENCES user_account (id),
    foreign KEY (item_id) REFERENCES item (id)
)
INHERITS (
    base_table
);

