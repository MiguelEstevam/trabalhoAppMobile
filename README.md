
# 📱 Aplicativo de Força de Venda

Este é um projeto desenvolvido para a disciplina de **Desenvolvimento Mobile** utilizando **Flutter**, com foco em um Aplicativo de Força de Venda. O sistema contempla cadastros e gerenciamento de usuários, clientes e produtos, com persistência de dados em arquivos JSON.

## 👨‍💻 Desenvolvedores

- Miguel França
- Guilherme dos Santos

## 🛠️ Tecnologias Utilizadas

- [Flutter](https://flutter.dev/) (sem uso de bibliotecas externas além das utilizadas em sala de aula)

## 📦 Funcionalidades

- Tela de **Login** com usuário inicial (`admin` / `admin`) caso não haja cadastro.
- Tela de **Cadastro de Usuário** com operações de **CRUD**.
- Tela de **Cadastro de Cliente** com operações de **CRUD**.
- Tela de **Cadastro de Produto** com operações de **CRUD**.
- Validação de campos obrigatórios marcados com `*`.
- Armazenamento dos dados em arquivos JSON nomeados conforme a entidade.

## 🧾 Estrutura de Dados

### Usuário
- `id`* (interno)
- `nome`*
- `senha`*

### Cliente
- `id`*
- `nome`*
- `tipo`* (F - Física / J - Jurídica)
- `cpfCnpj`*
- `email`
- `telefone`
- `cep`
- `endereco`
- `bairro`
- `cidade`
- `uf`

### Produto
- `id`*
- `nome`*
- `unidade`* (`un`, `cx`, `kg`, `lt`, `ml`)
- `qtdEstoque`*
- `precoVenda`*
- `status`* (`0` - Ativo / `1` - Inativo)
- `custo`
- `codigoBarra`

> **Nota:** Campos obrigatórios estão marcados com `*`.



