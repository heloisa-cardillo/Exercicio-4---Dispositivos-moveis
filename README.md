# Exercício 4 - Aplicativo de pedidos de restaurante

Exercício da disciplina Programação para Dispositivos Móveis

O app monta um pedido em cinco telas: prato principal, bebida, sobremesa, forma de pagamento e finalização

<details>
<summary><strong>Telas</strong></summary>

1. **Prato principal:** risoto de cogumelos, lasanha de berinjela ou moqueca de banana-da-terra.
2. **Bebida:** suco de laranja, de maracujá ou de abacaxi com hortelã.
3. **Sobremesa:** banana caramelizada, mousse de limão ou cream cheese.
4. **Forma de pagamento:** Pix, cartão de crédito, cartão de débito ou dinheiro.
5. **Finalização:** itens escolhidos, preço de cada um, total e forma de pagamento.

</details>

<details>
<summary><strong>Regras</strong></summary>

- Só dá para avançar depois de escolher uma opção.
- Nas telas 2, 3 e 4 dá para voltar à tela anterior ou direto ao início.
- Ao voltar, a escolha feita continua marcada e pode ser trocada.
- Da finalização não se volta às etapas anteriores. O botão "Novo pedido" recomeça o pedido do zero.
- Os valores aparecem em reais, com duas casas decimais.

</details>

<details>
<summary><strong>Recursos utilizados</strong></summary>

- `Navigator.push`, `Navigator.pop` e `Navigator.popUntil` para navegar entre as telas
- `MaterialPageRoute` para criar as rotas
- Dados passados entre as telas pelos construtores
- `StatefulWidget` e `setState` para controlar as seleções
- `PopScope` e `Navigator.pushAndRemoveUntil` para bloquear o retorno na finalização
- Ícones próprios em PNG em `assets/icones`

</details>

<details>
<summary><strong>Estrutura</strong></summary>

```
Exercicio-4---Dispositivos-moveis/
├── assets/
│   ├── icones/
│   └── midia/
│       └── video demostrativo.gif
├── lib/
│   ├── main.dart
│   ├── um.dart
│   ├── models/
│   │   └── item_cardapio.dart
│   ├── utils/
│   │   └── formatar_valor.dart
│   └── telas/
│       ├── tela_prato_principal.dart
│       ├── tela_bebida.dart
│       ├── tela_sobremesa.dart
│       ├── tela_pagamento.dart
│       └── tela_finalizacao.dart
├── web/
├── android/
└── pubspec.yaml
```

</details>

<details>
<summary><strong>Como executar</strong></summary>

```
flutter pub get
flutter run -t lib/um.dart -d chrome
```

</details>

<br>

![Demonstração do app](assets/midia/video%20demostrativo.gif)
