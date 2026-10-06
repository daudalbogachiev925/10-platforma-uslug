CREATE TABLE providers (
    id BIGSERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    phone TEXT,
    city TEXT,
    skills TEXT[],
    rating NUMERIC(3,2) DEFAULT 0,
    orders_done INT DEFAULT 0,
    created TIMESTAMP DEFAULT NOW()
);

CREATE TABLE customers (
    id BIGSERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    phone TEXT,
    city TEXT,
    created TIMESTAMP DEFAULT NOW()
);

CREATE TABLE services (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    category TEXT
);

CREATE TABLE orders (
    id BIGSERIAL PRIMARY KEY,
    customer_id BIGINT REFERENCES customers(id),
    provider_id BIGINT REFERENCES providers(id),
    service_id INT REFERENCES services(id),
    price NUMERIC(10,2),
    status TEXT DEFAULT 'new',
    address TEXT,
    created TIMESTAMP DEFAULT NOW(),
    completed TIMESTAMP
);

CREATE TABLE reviews (
    id BIGSERIAL PRIMARY KEY,
    order_id BIGINT REFERENCES orders(id),
    author_id BIGINT,
    author_role TEXT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    text TEXT,
    created TIMESTAMP DEFAULT NOW()
);

CREATE TABLE disputes (
    id BIGSERIAL PRIMARY KEY,
    order_id BIGINT REFERENCES orders(id),
    reason TEXT,
    status TEXT DEFAULT 'open',
    resolution TEXT,
    opened TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_orders_provider ON orders(provider_id);
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_providers_city ON providers(city);
