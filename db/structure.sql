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

--
-- Name: progress_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.progress_type AS ENUM (
    'tasks',
    'experience'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: areas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.areas (
    id bigint NOT NULL,
    title character varying,
    user_id bigint NOT NULL,
    progress_id bigint,
    parent_area_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: areas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.areas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: areas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.areas_id_seq OWNED BY public.areas.id;


--
-- Name: progresses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.progresses (
    id bigint NOT NULL,
    type public.progress_type,
    auto boolean DEFAULT true NOT NULL,
    amount integer,
    max integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: progresses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.progresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: progresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.progresses_id_seq OWNED BY public.progresses.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.projects (
    id bigint NOT NULL,
    title character varying,
    user_id bigint NOT NULL,
    progress_id bigint,
    area_id bigint,
    parent_project_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: tasks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tasks (
    id bigint NOT NULL,
    title text,
    done boolean DEFAULT false NOT NULL,
    done_at timestamp without time zone,
    value_points integer,
    difficulty_points integer,
    experience_points integer,
    user_id bigint NOT NULL,
    area_id bigint,
    project_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tasks_id_seq OWNED BY public.tasks.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    username character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: areas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.areas ALTER COLUMN id SET DEFAULT nextval('public.areas_id_seq'::regclass);


--
-- Name: progresses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.progresses ALTER COLUMN id SET DEFAULT nextval('public.progresses_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- Name: tasks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks ALTER COLUMN id SET DEFAULT nextval('public.tasks_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: areas areas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.areas
    ADD CONSTRAINT areas_pkey PRIMARY KEY (id);


--
-- Name: progresses progresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.progresses
    ADD CONSTRAINT progresses_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_areas_on_parent_area_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_areas_on_parent_area_id ON public.areas USING btree (parent_area_id);


--
-- Name: index_areas_on_progress_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_areas_on_progress_id ON public.areas USING btree (progress_id);


--
-- Name: index_areas_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_areas_on_user_id ON public.areas USING btree (user_id);


--
-- Name: index_progresses_on_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_progresses_on_type ON public.progresses USING btree (type);


--
-- Name: index_projects_on_area_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_area_id ON public.projects USING btree (area_id);


--
-- Name: index_projects_on_parent_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_parent_project_id ON public.projects USING btree (parent_project_id);


--
-- Name: index_projects_on_progress_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_progress_id ON public.projects USING btree (progress_id);


--
-- Name: index_projects_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_user_id ON public.projects USING btree (user_id);


--
-- Name: index_tasks_on_area_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tasks_on_area_id ON public.tasks USING btree (area_id);


--
-- Name: index_tasks_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tasks_on_project_id ON public.tasks USING btree (project_id);


--
-- Name: index_tasks_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tasks_on_user_id ON public.tasks USING btree (user_id);


--
-- Name: tasks fk_rails_02e851e3b7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT fk_rails_02e851e3b7 FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: tasks fk_rails_06fbd8648a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT fk_rails_06fbd8648a FOREIGN KEY (area_id) REFERENCES public.areas(id);


--
-- Name: areas fk_rails_33711d5943; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.areas
    ADD CONSTRAINT fk_rails_33711d5943 FOREIGN KEY (parent_area_id) REFERENCES public.areas(id);


--
-- Name: tasks fk_rails_4d2a9e4d7e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT fk_rails_4d2a9e4d7e FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: areas fk_rails_5539d33237; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.areas
    ADD CONSTRAINT fk_rails_5539d33237 FOREIGN KEY (progress_id) REFERENCES public.progresses(id);


--
-- Name: areas fk_rails_64ba63583c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.areas
    ADD CONSTRAINT fk_rails_64ba63583c FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: projects fk_rails_64e1bfeddf; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT fk_rails_64e1bfeddf FOREIGN KEY (area_id) REFERENCES public.areas(id);


--
-- Name: projects fk_rails_b134e2d27b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT fk_rails_b134e2d27b FOREIGN KEY (progress_id) REFERENCES public.progresses(id);


--
-- Name: projects fk_rails_b872a6760a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT fk_rails_b872a6760a FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: projects fk_rails_da606a66c1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT fk_rails_da606a66c1 FOREIGN KEY (parent_project_id) REFERENCES public.projects(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20210122210329'),
('20210122210440'),
('20210122210442'),
('20210122210448'),
('20210122210450');


