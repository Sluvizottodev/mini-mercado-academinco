# **Mini Mercado Acadêmico**  
**Aplicação Mobile**

![Logo](https://github.com/user-attachments/assets/c6771a8b-9c00-405d-a40a-28afbb28cf47)

Projeto acadêmico colaborativo para o desenvolvimento de um **mini mercado digital**, inspirado no supermercado **SuperPão**. O objetivo principal é oferecer uma plataforma simples para simular a experiência de compra online, focando no aprendizado prático de tecnologias modernas de desenvolvimento mobile, utilizando Flutter, Dart e Firebase.

---

## **Índice**

1. [Sobre o Projeto](#sobre-o-projeto)  
2. [Funcionalidades](#funcionalidades)  
3. [Arquitetura e Design](#arquitetura-e-design)  
4. [Tecnologias Utilizadas](#tecnologias-utilizadas)  
5. [Pré-requisitos e Configuração](#pre-requisitos-e-configuração)  
6. [Integrantes do Grupo](#integrantes-do-grupo)  
7. [Clone o repositório](#clone-o-repositorio)  

---

## **Sobre o Projeto**

O **Mini Mercado Acadêmico** é um aplicativo mobile desenvolvido como parte de um projeto acadêmico, visando proporcionar uma simulação realista de um mercado online. O objetivo é permitir que os usuários naveguem entre produtos, realizem compras e finalizem suas transações de maneira intuitiva e simples.

O projeto é uma excelente oportunidade para os desenvolvedores trabalharem em um ambiente colaborativo e colocarem em prática habilidades essenciais no desenvolvimento de aplicações modernas, como integração com serviços de backend em tempo real e a construção de uma interface fluida e responsiva para usuários móveis.

---

## **Funcionalidades**

### **Funcionalidades Principais**

- **Autenticação de Usuários**:  
  Permite que novos usuários se cadastrem e façam login utilizando e-mail e senha. Utiliza Firebase Authentication para gerenciamento de usuários.
  
- **Catálogo de Produtos**:  
  Exibição de uma lista de produtos disponíveis para compra, com filtro por categorias e buscas personalizadas.

- **Carrinho de Compras**:  
  Adição de produtos ao carrinho, com opções para modificar quantidades ou remover itens.

- **Finalização de Compra**:  
  Simulação de checkout, com formas de pagamento como "Dinheiro" ou "Cartão de Crédito". 

- **Simulação de Taxa de Entrega**:  
  A aplicação calcula a taxa de entrega com base no endereço selecionado pelo usuário (bairro e cidade pré-definidos).

- **Histórico de Compras**:  
  Possibilidade de o usuário visualizar pedidos anteriores.

- **Persistência de Dados**: A base de dados utiliza o **Firebase Firestore** para armazenar informações de produtos, pedidos e usuários em tempo real.

---

## **Tecnologias Utilizadas**

O projeto utiliza uma combinação de tecnologias modernas, tanto para o frontend quanto para o backend:

- **[Flutter](https://flutter.dev/)**: Framework para desenvolvimento mobile multiplataforma (Android/iOS).
- **[Dart](https://dart.dev/)**: Linguagem de programação utilizada pelo Flutter, ideal para desenvolvimento de interfaces modernas.
- **[Firebase Authentication](https://firebase.google.com/products/auth)**: Para autenticação de usuários.
- **[Firebase Firestore](https://firebase.google.com/products/firestore)**: Banco de dados NoSQL para armazenamento em tempo real.

---

## **Pré-requisitos e Configuração**

### **Pré-requisitos**
- **Flutter** 3.22.2
- **Dart** 3.4.3
- **Firebase CLI** configurado na máquina local
- **Android Studio** ou **Visual Studio Code** com extensões do Flutter

---

## **Integrantes do Grupo**

- **Stefani Luvizotto de Souza** 
- **Jonatas Borges da Silva e Silva** 
- **Antonio Henrique Gomes Ther**
- **Gabriel de Almeida Martins da Cruz**

---

## **Clone o repositório**:
   ```bash
   git clone https://github.com/Sluvizottodev/mini-mercado-academico.git
