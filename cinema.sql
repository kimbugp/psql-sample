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
    date_of_release date DEFAULT now(),
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
    cinemahall_id integer NOT NULL
);

ALTER TABLE showtime
    ADD CONSTRAINT cinemahall_showtime_fk FOREIGN KEY (cinemahall_id) REFERENCES cinemahall (id) ON DELETE CASCADE,
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

INSERT INTO users (email, PASSWORD, name, is_staff)
    VALUES ('peter@gmail.com', 'sha256$HwJeg0Ig$24f5e0f26fe2eb7ffa116b681f90e2f8383c4d0802dd48f5259d43885b38a23d', 'Simon Peter K', 'true');

INSERT INTO cinemahall (name, description)
    VALUES ('Cinema1', 'SOme data'), ('Cimena2', 'something esle'), ('Cinema 3', 'slef');

INSERT INTO movie (date_of_release, name, category, rating, length, summary)
    VALUES ('2019-08-05 00:00:00', 'sim', 'horror', 1, '2:30', 'sdfsdfdgdsd'), ('2019-08-06 00:00:00', 'lord of rings', 'times', 5, '2:30', 'sdfdsdfghferw');

INSERT INTO showtime (cinemahall_id, movie_id, show_datetime, price)
    VALUES (1, 1, '2019-08-29 12:49:18', 20000), (1, 1, '2019-08-29 14:49:18', 30000), (2, 2, '2019-08-29 16:49:18', 20000), (2, 1, '2019-08-29 18:49:18', 20000), (3, 1, '2019-08-29 20:49:18', 20000), (2, 2, '2019-08-06 12:00:00', 20000), (2, 2, '2019-08-04 12:00:00', 20000);

INSERT INTO seat (number, cinemahall_id, name)
    VALUES (1, 1, 'a'), (2, 1, 'b'), (3, 1, 'c'), (2, 1, 'd'), (4, 1, 'e'), (1, 2, 'f'), (4, 2, 'g');

INSERT INTO ticket (payment_method, seat_id, user_id, showtime_id)
    VALUES ('mm', 1, 1, 1), ('mm', 2, 1, 1), ('mm', 3, 1, 1), ('mm', 4, 1, 2), ('mm', 5, 1, 4), ('mm', 6, 1, 4)
