CREATE TABLE users (
    id serial PRIMARY KEY,
    date_created timestamp DEFAULT now(),
    email varchar(100) NOT NULL UNIQUE,
    PASSWORD varchar(100) NOT NULL,
    name varchar(100) NOT NULL,
    is_staff boolean DEFAULT TRUE
);

CREATE TABLE movie (
    id serial PRIMARY KEY,
    date_created timestamp DEFAULT now(),
    name varchar(50) NOT NULL,
    category varchar(100) NOT NULL,
    date_of_realease date DEFAULT now(),
    rating integer CHECK (rating BETWEEN 0 AND 10) DEFAULT 10,
    length time NOT NULL,
    summary text NULL
);

CREATE TABLE cinemahall (
    id serial PRIMARY KEY,
    date_created timestamp DEFAULT now(),
    name varchar(50) NOT NULL,
    description varchar(100) NOT NULL
);

CREATE TABLE seat (
    id serial PRIMARY KEY,
    date_created timestamp DEFAULT now(),
    name varchar(50) NOT NULL,
    number integer NOT NULL,
    cinemahall_id integer
);

ALTER TABLE seat
    ADD CONSTRAINT seat_name_cinema_hall_number_key UNIQUE (name, number, cinemahall_id),
    ADD CONSTRAINT cinemahall_seat_fk FOREIGN KEY (cinemahall_id) REFERENCES cinemahall (id) ON DELETE CASCADE;

CREATE TABLE showtime (
    id serial PRIMARY KEY,
    date_created timestamp DEFAULT now(),
    show_datetime timestamp NOT NULL,
    movie_id integer NOT NULL,
    price numeric NOT NULL,
    cinema_hall_id integer NOT NULL
);

ALTER TABLE showtime
    ADD CONSTRAINT cinemahall_showtime_fk FOREIGN KEY (cinema_hall_id) REFERENCES cinemahall (id) ON DELETE CASCADE,
    ADD CONSTRAINT movie_showtime_fk FOREIGN KEY (movie_id) REFERENCES movie (id) ON DELETE CASCADE;

CREATE TABLE ticket (
    id serial PRIMARY KEY,
    date_created timestamp DEFAULT now(),
    payment_method varchar(100) NOT NULL,
    user_id integer NULL REFERENCES users (id) ON DELETE CASCADE,
    showtime_id integer NOT NULL,
    seat_id integer NOT NULL
);

ALTER TABLE ticket
    ADD CONSTRAINT showtime_ticket_fk FOREIGN KEY (showtime_id) REFERENCES showtime (id) ON DELETE RESTRICT,
    ADD CONSTRAINT seat_ticket_fk FOREIGN KEY (seat_id) REFERENCES seat (id) ON DELETE RESTRICT,
    ADD CONSTRAINT showtime_seat_id_key UNIQUE (showtime_id, seat_id);

