
insert into usuarios (nome, email, telefone, cpf)
values
  ('Ana Silva', 'ana.silva@example.com', '11987654321', '20560053606'),
  ('Carlos Souza', 'carlos.souza@example.com', '21998765432', '40206301600'),
  ('Mariana Lima', 'mariana.lima@example.com', '31976543210', '27157562324')
on conflict (cpf) do nothing;

insert into livros (nome_autor, titulo_livro, editora, quantidade, ano_publicacao, genero)
values
  ('Machado de Assis', 'Dom Casmurro', 'Editora Brasil', 3, 1899, 'Romance'),
  ('George Orwell', '1984', 'Companhia das Letras', 5, 1949, 'Distopia'),
  ('J. K. Rowling', 'Harry Potter e a Pedra Filosofal', 'Rocco', 4, 1997, 'Fantasia'),
  ('Yuval Noah Harari', 'Sapiens', 'Objetiva', 2, 2011, 'História'),
  ('Clarice Lispector', 'A Hora da Estrela', 'Rocco', 1, 1977, 'Ficção');

insert into emprestimos (usuario_id, livro_id, data_emprestimo, data_devolucao, status, valor_devedor, data_prevista_devolucao)
values
  (
    (select id from usuarios where cpf = '20560053606'),
    (select id from livros where titulo_livro = 'Dom Casmurro' and nome_autor = 'Machado de Assis'),
    '2026-06-01', null, 'emprestado', 0.00, '2026-06-08'
  ),
  (
    (select id from usuarios where cpf = '40206301600'),
    (select id from livros where titulo_livro = '1984' and nome_autor = 'George Orwell'),
    '2026-05-28', '2026-06-04', 'devolvido', 0.00, '2026-06-04'
  ),
  (
    (select id from usuarios where cpf = '27157562324'),
    (select id from livros where titulo_livro = 'Harry Potter e a Pedra Filosofal' and nome_autor = 'J. K. Rowling'),
    '2026-06-02', null, 'emprestado', 0.00, '2026-06-09'
  ),
  (
    (select id from usuarios where cpf = '20560053606'),
    (select id from livros where titulo_livro = 'Sapiens' and nome_autor = 'Yuval Noah Harari'),
    '2026-05-20', '2026-05-27', 'devolvido', 0.00, '2026-05-27'
  );
