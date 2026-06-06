CREATE TABLE public.usuarios (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  nome character varying NOT NULL CHECK (btrim(nome::text) <> ''::text),
  email character varying NOT NULL UNIQUE CHECK (btrim(email::text) <> ''::text),
  telefone character varying,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  cpf character varying NOT NULL UNIQUE CHECK (length(regexp_replace(cpf::text, '\\D'::text, ''::text, 'g'::text)) = 11 AND regexp_replace(cpf::text, '\\D'::text, ''::text, 'g'::text) ~ '^\\d{11}$'::text),
  CONSTRAINT usuarios_pkey PRIMARY KEY (id)
);
CREATE TABLE public.livros (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  nome_autor character varying NOT NULL CHECK (btrim(nome_autor::text) <> ''::text),
  titulo_livro character varying NOT NULL CHECK (btrim(titulo_livro::text) <> ''::text),
  editora character varying,
  quantidade integer NOT NULL DEFAULT 0 CHECK (quantidade >= 0),
  ano_publicacao integer CHECK (ano_publicacao IS NULL OR ano_publicacao >= 0),
  genero character varying,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT livros_pkey PRIMARY KEY (id)
);
CREATE TABLE public.emprestimos (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  usuario_id bigint NOT NULL,
  livro_id bigint NOT NULL,
  data_emprestimo date NOT NULL DEFAULT CURRENT_DATE,
  data_devolucao date,
  status character varying NOT NULL DEFAULT 'emprestado'::character varying CHECK (status::text = ANY (ARRAY['emprestado'::character varying, 'devolvido'::character varying]::text[])),
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  valor_devedor numeric NOT NULL DEFAULT 0.00 CHECK (valor_devedor >= 0::numeric),
  data_prevista_devolucao date,
  CONSTRAINT emprestimos_pkey PRIMARY KEY (id),
  CONSTRAINT emprestimos_usuario_fk FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id),
  CONSTRAINT emprestimos_livro_fk FOREIGN KEY (livro_id) REFERENCES public.livros(id)
);
CREATE TABLE public.admins (
  id bigint NOT NULL DEFAULT nextval('admins_id_seq'::regclass),
  username text NOT NULL UNIQUE,
  password text NOT NULL,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT admins_pkey PRIMARY KEY (id)
);