# Banco de Dados - Sistema Biblioteca

Esta pasta guarda os scripts SQL do banco de dados do sistema de biblioteca.

O banco usado e PostgreSQL. No desenvolvimento local ele roda pelo Docker, usando a imagem `postgres:15-alpine`. Em producao/testes externos, o projeto tambem pode usar o Supabase, que usa PostgreSQL por baixo.

## Boas praticas usadas no SQL

### DEFAULT

`DEFAULT` define um valor automatico quando o sistema nao envia aquele campo no `insert`.

Exemplos usados:

- `data_emprestimo date not null default current_date`: se o backend nao informar a data, o banco usa a data atual.
- `status varchar(20) not null default 'emprestado'`: se o backend nao informar o status, o banco cria o emprestimo como `emprestado`.
- `created_at timestamp with time zone not null default now()`: registra automaticamente quando o registro foi criado.

### CONSTRAINT

`CONSTRAINT` e uma regra que o banco obriga os dados a respeitarem. Isso evita dados invalidos mesmo se algum erro passar pelo backend.

Tipos usados neste projeto:

- `primary key`: identifica cada registro de forma unica.
- `unique`: impede repeticao de um valor, como o email do usuario.
- `check`: valida uma regra, como quantidade nao ser negativa.
- `foreign key`: garante relacionamento entre tabelas.

### FOREIGN KEY

`FOREIGN KEY` liga uma tabela a outra. No projeto:

- `emprestimos.usuario_id` referencia `usuarios.id`.
- `emprestimos.livro_id` referencia `livros.id`.

Isso significa que nao da para cadastrar um emprestimo para um usuario ou livro que nao existe.

## Tabelas criadas

### usuarios

Guarda os dados dos usuarios do sistema.

Campos principais:

- `id`
- `nome`
- `email`
- `telefone`
- `data_nascimento`
- `senha`
- `created_at`

Regras importantes:

- `id` e chave primaria.
- `email` nao pode repetir.
- `nome`, `email` e `senha` nao podem ser vazios.

### livros

Guarda os dados dos livros cadastrados.

Campos principais:

- `id`
- `nome_autor`
- `titulo_livro`
- `editora`
- `quantidade`
- `ano_publicacao`
- `genero`
- `created_at`

Regras importantes:

- `id` e chave primaria.
- `nome_autor` e `titulo_livro` nao podem ser vazios.
- `quantidade` nao pode ser menor que `0`.
- `ano_publicacao` precisa ser nulo ou maior/igual a `0`.

### emprestimos

Guarda os emprestimos e devolucoes dos livros.

Campos principais:

- `id`
- `usuario_id`
- `livro_id`
- `data_emprestimo`
- `data_devolucao`
- `status`
- `created_at`

Regras importantes:

- `id` e chave primaria.
- `usuario_id` precisa existir na tabela `usuarios`.
- `livro_id` precisa existir na tabela `livros`.
- `data_emprestimo` usa a data atual por padrao.
- `status` usa `emprestado` por padrao.
- `status` pode ser apenas `emprestado` ou `devolvido`.
- Se o status for `emprestado`, `data_devolucao` deve ficar vazia.
- Se o status for `devolvido`, `data_devolucao` deve estar preenchida e nao pode ser anterior a `data_emprestimo`.

## Regras de negocio

- Um livro so pode ser emprestado se existir e tiver `quantidade > 0`.
- Ao registrar um emprestimo, a quantidade do livro diminui em `1`.
- Ao registrar uma devolucao, o status muda para `devolvido`, `data_devolucao` recebe a data atual e a quantidade do livro aumenta em `1`.
- Um emprestimo ja devolvido nao pode ser devolvido novamente.
- Um emprestimo e considerado atrasado quando esta com status `emprestado` e tem mais de 7 dias.
- Nao pode existir emprestimo ligado a usuario ou livro inexistente.

## Requisitos funcionais

- RF01: Cadastrar livros.
- RF02: Listar livros.
- RF03: Atualizar livros.
- RF04: Excluir livros.
- RF05: Verificar disponibilidade de livro.
- RF06: Cadastrar usuarios.
- RF07: Listar usuarios.
- RF08: Registrar emprestimo.
- RF09: Registrar devolucao.
- RF10: Listar historico de emprestimos.
- RF11: Listar emprestimos atrasados.

## Requisitos nao funcionais

- RNF01: Usar PostgreSQL como banco de dados.
- RNF02: Permitir execucao local com Docker.
- RNF03: Manter integridade dos dados com `constraints`.
- RNF04: Manter integridade referencial com `foreign keys`.
- RNF05: Usar transacoes no emprestimo e na devolucao para evitar inconsistencia na quantidade dos livros.
- RNF06: Disponibilizar respostas em JSON pela API.

## Exemplos para teste

Depois de criar as tabelas, voce pode testar com estes comandos no `SQL Editor`:

```sql
insert into usuarios (nome, email, telefone, data_nascimento, senha)
values ('Maria Silva', 'maria@email.com', '11999999999', '2000-05-10', '123456');

insert into livros (nome_autor, titulo_livro, editora, quantidade, ano_publicacao, genero)
values ('Machado de Assis', 'Dom Casmurro', 'Editora Exemplo', 3, 1899, 'Romance');

insert into emprestimos (usuario_id, livro_id)
values (1, 1);

update emprestimos
set status = 'devolvido',
    data_devolucao = current_date
where id = 1;
```

Observacao: `create table if not exists` nao altera uma tabela que ja existe. Se o banco ja foi criado antes, e preciso aplicar `alter table` ou recriar o banco/volume para pegar novas constraints.
