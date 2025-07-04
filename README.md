Marciel Miranda de Paula - marciel.tads@gmail.com  @2025 — MBAonRails Arquitetura de Aplicações Web com Rails

# Sistema de Gerenciamento de Usuários e Pedidos - Desafio prático MBA Rails


Aplicativo desenvolvido como parte do desafio prático da pós-graduação em Ruby on Rails, utilizando uma arquitetura moderna, modular e de fácil manutenção.

---

## Como rodar o projeto

### Video demonstrando o processo, o audio esta horrivel.

[![Watch the video](https://img.youtube.com/vi/AWVLgNeeR80/0.jpg)](https://youtu.be/AWVLgNeeR80)




### 1. Clonar o repositório e abrir no VSCode com DevContainers

```bash
git clone <repo>
cd <repo>
code .
```

> O VSCode deve estar com a extensão **Dev Containers** instalada e configurada.

### 2. Suba o ambiente com DevContainer

O ambiente já instalará as dependências, criará o banco, aplicará as migrações e rodará os seeds automaticamente.

> Caso os dados de exemplo (admin, usuários, produtos) **não apareçam na aplicação**, rode manualmente:
>
> ```bash
> bin/rails db:seed:replant
> ```

### 3. Suba a aplicação Rails

```bash
bundle exec rails s -b 0.0.0.0
```

### 4. Acesse os serviços:

| Recurso            | Endereço                       |
|--------------------|---------------------------------|
| App principal      | http://localhost:3030           |
| Mailcatcher        | http://localhost:1081           |
| Sidekiq Dashboard  | http://localhost:3030/sidekiq/  |

---

## Funcionalidades

- Cadastro e autenticação de usuários
- Perfis de **admin** e **cliente**
- Admin pode:
  - Gerenciar usuários
  - Gerenciar produtos
  - Acompanhar pedidos
  - Criar pedidos com produtos dinâmicos (nested form)
- Cliente pode:
  - Criar conta
  - Visualizar produtos
  - Criar pedidos com produtos dinâmicos (nested form)

---

## Padrões aplicados

| Padrão                      | Local aplicação                                                       | Objetivo                                                                                                               |
|-----------------------------|-----------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------|
| **Service Objects**         | `Users::CreateService`, `Users::UpdateService`, `Orders::CreateService` | Centraliza lógicas de negócio, para criar users e orders, atualizar users                                              |
| **ActiveJob + Sidekiq**     | `WelcomeEmailJob`, `OrderConfirmationJob`, `ExportOrdersReportJob`                           | Processamento assíncrono de e-mail, basicamente envio simples via backgroundjob e também evia um xls                   |
| **ActiveSupport::Notifications** | `user.created`, `order.created`                                       | Observador implícito, gera log, e em orders, envia e-mail                                                              |
| **Concerns**                | `SoftDeletable`                                                       | Soft delete reutilizável, e alguns scope compartilhados                                                                |
| **Query Objects**           | `OrdersQuery`, `scopes em user e order`                               | Filtros de consulta desacoplado do modelo original                                                                     |
| **Decorators**              | `UserDecorator`, `OrderDecorator`                                     | Decorator com Draper, basicamente decora o model e da uns super poderes a eles                                         |
| **Nested Forms com Stimulus**| `client/orders/new.html.erb`, `nested-form.js`                        | Me aventurando a criar um nested com stimulus, foge um pouco do escopo da avaliação, mas gostei do aprendizado, citei. |

---

## Email de boas-vindas confirmação de pedidos, Relatorio

- Enviados automaticamente usando Sidekiq
- Capturados no [Mailcatcher](http://localhost:1081/)

---

## Seeds

- 1 Admin: `admin@mbaonrails.com`, senha `123456`
- 10 usuários clientes
- 100 produtos randômicos



