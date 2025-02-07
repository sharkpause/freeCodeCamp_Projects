--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    type text NOT NULL,
    name character varying(30),
    age_in_millions_of_years integer,
    cluster_id integer
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_cluster; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy_cluster (
    galaxy_cluster_id integer NOT NULL,
    name character varying(30) NOT NULL,
    description text
);


ALTER TABLE public.galaxy_cluster OWNER TO freecodecamp;

--
-- Name: galaxy_cluster_primary_key_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_cluster_primary_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_cluster_primary_key_seq OWNER TO freecodecamp;

--
-- Name: galaxy_cluster_primary_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_cluster_primary_key_seq OWNED BY public.galaxy_cluster.galaxy_cluster_id;


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(30),
    radius_in_km integer NOT NULL,
    habitable boolean,
    planet_id integer
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(30) NOT NULL,
    type text NOT NULL,
    radius_in_km integer NOT NULL,
    habitable boolean,
    star_id integer
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(30) NOT NULL,
    type text NOT NULL,
    age_in_millions_of_years numeric(10,2),
    galaxy_id integer
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: galaxy_cluster galaxy_cluster_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy_cluster ALTER COLUMN galaxy_cluster_id SET DEFAULT nextval('public.galaxy_cluster_primary_key_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (3, 'Spiral', 'Andromeda', 10000, 4);
INSERT INTO public.galaxy VALUES (4, 'Spiral', 'Triangulum Galaxy', 12000, 4);
INSERT INTO public.galaxy VALUES (5, 'Spiral', 'Sombrero Galaxy', 12000, 1);
INSERT INTO public.galaxy VALUES (6, 'Spiral', 'Whirlpool Galaxy', 500, 5);
INSERT INTO public.galaxy VALUES (7, 'Elliptical', 'Centaurus A', 10000, 6);
INSERT INTO public.galaxy VALUES (1, 'Spiral', 'Milky way', 13600, 4);


--
-- Data for Name: galaxy_cluster; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy_cluster VALUES (1, 'Virgo Cluster', 'The nearest massive galaxy cluster to us');
INSERT INTO public.galaxy_cluster VALUES (2, 'Norma Cluster', 'The cluster at the heart of the Great Attractor');
INSERT INTO public.galaxy_cluster VALUES (3, 'Bullet Cluster', 'A cluster merger with the first observed separation between dark matter and normal matter');
INSERT INTO public.galaxy_cluster VALUES (4, 'Local Group', NULL);
INSERT INTO public.galaxy_cluster VALUES (5, 'Canes Venatici I Group', NULL);
INSERT INTO public.galaxy_cluster VALUES (6, 'Centaurus Cluster', NULL);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Luna', 1737, false, 1);
INSERT INTO public.moon VALUES (2, 'Phobos', 11, false, 2);
INSERT INTO public.moon VALUES (3, 'Deimos', 6, false, 2);
INSERT INTO public.moon VALUES (4, 'Europa', 1560, false, 3);
INSERT INTO public.moon VALUES (5, 'Ganymede', 2634, false, 3);
INSERT INTO public.moon VALUES (6, 'Callisto', 2410, false, 3);
INSERT INTO public.moon VALUES (7, 'Io', 1821, false, 3);
INSERT INTO public.moon VALUES (8, 'Titan', 2575, false, 4);
INSERT INTO public.moon VALUES (9, 'Rhea', 764, false, 4);
INSERT INTO public.moon VALUES (10, 'Iapetus', 734, false, 4);
INSERT INTO public.moon VALUES (11, 'Dione', 561, false, 4);
INSERT INTO public.moon VALUES (12, 'Tethys', 531, false, 4);
INSERT INTO public.moon VALUES (13, 'Enceladus', 252, false, 4);
INSERT INTO public.moon VALUES (14, 'Miranda', 236, false, 8);
INSERT INTO public.moon VALUES (15, 'Oberon', 761, false, 8);
INSERT INTO public.moon VALUES (16, 'Ariel', 578, false, 8);
INSERT INTO public.moon VALUES (17, 'Umbriel', 584, false, 8);
INSERT INTO public.moon VALUES (18, 'Triton', 1353, false, 7);
INSERT INTO public.moon VALUES (19, 'Charon', 606, false, 12);
INSERT INTO public.moon VALUES (20, 'Mimas', 198, false, 4);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Earth', 'Rocky', 6371, true, 1);
INSERT INTO public.planet VALUES (2, 'Mars', 'Terrestrial', 3390, false, 1);
INSERT INTO public.planet VALUES (3, 'Jupiter', 'Gas Giant', 69911, false, 1);
INSERT INTO public.planet VALUES (4, 'Saturn', 'Gas Giant', 58232, false, 1);
INSERT INTO public.planet VALUES (5, 'Venus', 'Terrestrial', 6052, false, 1);
INSERT INTO public.planet VALUES (6, 'Mercury', 'Terrestrial', 2440, false, 1);
INSERT INTO public.planet VALUES (7, 'Neptune', 'Ice Giant', 24622, false, 1);
INSERT INTO public.planet VALUES (8, 'Uranus', 'Ice Giant', 25362, false, 1);
INSERT INTO public.planet VALUES (9, 'Proxima Centauri b', 'Terrestrial', 7020, true, 5);
INSERT INTO public.planet VALUES (10, 'Gliese 561g', 'Super-Earth', 11400, true, 7);
INSERT INTO public.planet VALUES (11, 'TRAPPIST-1e', 'Terrestrial', 5889, true, 8);
INSERT INTO public.planet VALUES (12, 'Kepler-22b', 'Super-Earth', 12000, true, 9);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Sun', 'Yellow Dwarf', 4600.00, 1);
INSERT INTO public.star VALUES (2, 'Sirius', 'A-type Main-Sequence', 242.00, 1);
INSERT INTO public.star VALUES (3, 'Betelgeuse', 'Red Supergiant', 10.00, 1);
INSERT INTO public.star VALUES (4, 'Rigel', 'Blue Supergiant', 8.00, 1);
INSERT INTO public.star VALUES (5, 'Promixa Centauri', 'Red Dwarf', 4850.00, 1);
INSERT INTO public.star VALUES (6, 'Vega', 'A-type Main-Sequence', 455.00, 1);
INSERT INTO public.star VALUES (7, 'Gliese 581', 'M-type Main-Sequence', NULL, 1);
INSERT INTO public.star VALUES (8, 'TRAPPIST-1', 'M-type Main-sequence', NULL, 1);
INSERT INTO public.star VALUES (9, 'Kepler-22', 'G-type Main-sequence', NULL, 1);


--
-- Name: galaxy_cluster_primary_key_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_cluster_primary_key_seq', 6, true);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 7, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 20, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 9, true);


--
-- Name: galaxy_cluster galaxy_cluster_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy_cluster
    ADD CONSTRAINT galaxy_cluster_name_key UNIQUE (name);


--
-- Name: galaxy_cluster galaxy_cluster_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy_cluster
    ADD CONSTRAINT galaxy_cluster_pkey PRIMARY KEY (galaxy_cluster_id);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

