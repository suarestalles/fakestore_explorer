# FakeStore Explorer

![Status do Projeto](https://img.shields.io/badge/Status-Em%20Desenvolvimento-yellow) 
> Um aplicativo Flutter para gerenciamento de lista de produtos com recursos de favoritos locais, autenticação de usuário e gerenciamento de estado avançado.

## 🌟 Visão Geral

O **FakeStore Explorer** é um aplicativo mobile desenvolvido com Flutter que consome uma API externa de produtos (FakeStore), permitindo ao usuário navegar, buscar e gerenciar uma lista de produtos favoritos. A gestão de favoritos é persistente e realizada de forma eficiente no dispositivo. O aplicativo também conta com um sistema de autenticação simples e gerenciamento de temas (Light/Dark).

### 💡 Principais Funcionalidades

* **Listagem de Produtos:** Exibe todos os produtos da API FakeStore.
* **Detalhes do Produto:** Visualização aprofundada das informações de um produto específico.
* **Gerenciamento de Favoritos:** Permite ao usuário adicionar/remover produtos à sua lista de favoritos, salvos localmente com **ObjectBox**.
* **Busca e Filtro:** Funcionalidades de busca por nome do produto e filtro por categorias nas telas de listagem.
* **Autenticação de Usuário:** Sistema de login simples utilizando **Firebase Auth**.
* **Gerenciamento de Temas:** Opção de alternar entre o tema claro (Light) e o tema escuro (Dark).

## 🏛️ Arquitetura do Projeto: MVC com Getx

O projeto segue o padrão de arquitetura **Model-View-Controller (MVC)**, facilitando a separação de responsabilidades, a manutenção e a escalabilidade do código.

| Componente | Responsabilidade | Ferramenta/Tecnologia |
| :--- | :--- | :--- |
| **Model** | Representação dos dados (classe de produtos) e a lógica de negócios (acesso a dados, regras). | Classes de dados (Models), ObjectBox (Banco Local), Chamadas à FakeStore API. |
| **View (Páginas)** | Interface do usuário (UI) e a apresentação visual. Apenas recebe as interações do usuário e as passa ao Controller. | Widgets do Flutter, Páginas do Getx. |
| **Controller** | Gerencia a lógica do estado, recebe as interações da View, manipula os Models e atualiza a View. | **Getx Controllers** (`GetxController`). |

Esta abordagem, implementada com o **Getx**, garante um gerenciamento de estado reativo e um acoplamento mínimo entre a interface e a lógica.

## 🚀 Tecnologias Utilizadas

O projeto foi construído utilizando as seguintes ferramentas e bibliotecas:

* **Flutter:** Framework para desenvolvimento mobile.
* **Dart:** Linguagem de programação.
* **Getx:** Gerenciador de estados, dependências e rotas. (utilizado pelo tempo de experiência, facilidade de implementação e robustez da biblioteca)
* **FakeStore API:** API RESTful pública utilizada para obter os dados de produtos.
* **ObjectBox:** Banco de dados NoSQL performático e reativo para persistência local dos favoritos. (utilizado pela prévia experiência em outros projetos)
* **Firebase Authentication (FirebaseAuth):** Serviço para gerenciar o login e autenticação de usuários. (utilizado pela facilidade de implementação e usabilidade, sem muita complexidade)

## 🛠️ Próximos Passos (Roadmap)

Os seguintes recursos estão planejados para futuras versões:

* **Persistência de Favoritos no Firebase:** Implementar a sincronização da lista de favoritos com o **Firebase Firestore/Realtime Database** por usuário, permitindo que a lista seja acessada em diferentes dispositivos.
* **Internacionalização (i18n):** Implementar a internacionalização completa do aplicativo utilizando a biblioteca `l10n` do Flutter para suportar múltiplos idiomas.

## ⚙️ Instalação e Execução

Para rodar este projeto localmente, siga os passos abaixo:

### Pré-requisitos

Certifique-se de ter instalado em sua máquina:

* [Flutter SDK](https://flutter.dev/docs/get-started/install)
* Conta e projeto no Firebase configurado com Authentication.

### Passos

1.  **Clone o repositório:**

    ```bash
    git clone https://github.com/suarestalles/fakestore_explorer.git
    cd fakestore_explorer
    ```

2.  **Instale as dependências:**

    ```bash
    flutter pub get
    ```

3.  **Execute o ObjectBox Generator (necessário para gerar os arquivos do banco de dados local):**
    
    > **Nota:** Certifique-se de ter o `build_runner` instalado globalmente ou no projeto, se necessário.
    
    ```bash
    flutter pub run build_runner build
    ```

4.  **Execute o aplicativo:**

    ```bash
    flutter run
    ```

### Instalação pelo APK


Vou deixar o link do .apk aqui caso prefira instalar em seu dispositivo Android:
* [APK](https://1drv.ms/u/c/d81422e88fb205a8/EekTfUgv0CdFpq2vVwLY4xUBFV3yQetsWQyzwEoxjpOyhQ?e=mcP7fZ)


## 🔐 Instruções de Login

Para testar o recurso de autenticação, utilize as seguintes credenciais de teste:

* **Email:** `user_test@fakestoreexp.com`
* **Password:** `usertestfakestore`

---
Feito com ❤️ por **Talles Suares**
