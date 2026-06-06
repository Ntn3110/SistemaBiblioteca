# Banco de Dados - Sistema Biblioteca

Este diretório descreve o banco de dados usado pelo sistema da biblioteca.

O banco é PostgreSQL e as tabelas estão em `BancoDeDados/database/grandetabela.sql`.

## Tabelas e colunas

### usuarios
Armazena as pessoas que usam o sistema.

- `id`: número único do usuário.
- `nome`: nome completo do usuário.
- `email`: e-mail do usuário. Não pode repetir.
- `telefone`: telefone do usuário (opcional).
- `cpf`: CPF do usuário. Não pode repetir e deve ter 11 dígitos.
- `created_at`: data/hora em que o usuário foi criado no banco.

### livros
Armazena os livros disponíveis na biblioteca.

- `id`: número único do livro.
- `nome_autor`: nome do autor.
- `titulo_livro`: título do livro.
- `editora`: editora do livro (opcional).
- `quantidade`: quantos exemplares existem.
- `ano_publicacao`: ano em que o livro foi publicado (pode ficar vazio).
- `genero`: gênero do livro (opcional).
- `created_at`: data/hora em que o livro foi registrado.

### emprestimos
Armazena cada empréstimo ou devolução de livro.

- `id`: número único do empréstimo.
- `usuario_id`: referência para `usuarios.id`.
- `livro_id`: referência para `livros.id`.
- `data_emprestimo`: data do empréstimo.
- `data_devolucao`: data da devolução (fica vazia enquanto o livro está emprestado).
- `status`: `emprestado` ou `devolvido`.
- `valor_devedor`: valor que o usuário deve (se houver).
- `data_prevista_devolucao`: data prevista para a devolução.
- `created_at`: data/hora em que o empréstimo foi registrado.

### admins
Armazena logins de administradores do sistema.

- `id`: número único do administrador.
- `username`: login do administrador. Não pode repetir.
- `password`: senha do administrador.
- `created_at`: data/hora em que o administrador foi registrado.

## Regras básicas importantes

- `id` é a chave principal em todas as tabelas.
- `email` e `cpf` em `usuarios` não podem se repetir.
- `usuario_id` em `emprestimos` só pode apontar para um usuário que existe.
- `livro_id` em `emprestimos` só pode apontar para um livro que existe.
- `quantidade` em `livros` não pode ser menor que 0.
- `status` em `emprestimos` só pode ser `emprestado` ou `devolvido`.
- `data_emprestimo` é preenchida automaticamente com a data atual.

## Como entender o SQL

O arquivo `grandetabela.sql` cria as três tabelas com todas essas colunas e regras.

- `DEFAULT` cria valores automáticos quando não é enviado nada na hora do `insert`.
- `UNIQUE` evita que valores iguais fiquem repetidos.
- `CHECK` garante regras simples como `quantidade >= 0`.
- `FOREIGN KEY` garante que um empréstimo só use usuário e livro válidos.
