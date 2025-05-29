# App Todo List

## Descrição do Projeto

Este é um aplicativo de lista de tarefas (Todo List) desenvolvido com Flutter. Ele permite que os usuários adicionem, editem, marquem como concluídas e removam tarefas. A interface é intuitiva, com um layout moderno e focado na produtividade. A separação entre tarefas pendentes e concluídas ajuda na organização visual.
O projeto foi construído com gerenciamento de estado utilizando **Bloc (Cubit)**, promovendo uma arquitetura limpa e reativa.

## Arquitetura

O projeto segue o padrão de arquitetura MVU (Model-View-Update) utilizando o gerenciador de estado Bloc/Cubit. 
A lógica de negócios é separada da interface por meio do Cubit, que gerencia ações como adicionar, editar, excluir e marcar tarefas. 
O estado é tratado de forma imutável, e a UI reage às mudanças com BlocBuilder, garantindo um fluxo de dados claro, previsível e escalável.

## Tecnologias Utilizadas
  - Flutter/Dart
  - Bloc/Cubit
  - UUID
  - Flutter Widgets

