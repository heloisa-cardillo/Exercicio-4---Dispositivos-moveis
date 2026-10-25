import 'package:exercicio_4/models/item_cardapio.dart';
import 'package:exercicio_4/telas/tela_pagamento.dart';
import 'package:exercicio_4/utils/formatar_valor.dart';
import 'package:flutter/material.dart';

class TelaSobremesa extends StatefulWidget {
  final ItemCardapio prato;
  final ItemCardapio bebida;

  const TelaSobremesa({super.key, required this.prato, required this.bebida});

  @override
  State<TelaSobremesa> createState() => _TelaSobremesaState();
}

class _TelaSobremesaState extends State<TelaSobremesa> {
  final List<ItemCardapio> sobremesas = const [
    ItemCardapio('Banana caramelizada', 14.00),
    ItemCardapio('Mousse de limão', 12.50),
    ItemCardapio('Cream cheese', 15.90),
  ];

  final List<String> icones = const [
    'banana_caramelizada',
    'mousse_limao',
    'cream_cheese',
  ];

  ItemCardapio? sobremesaSelecionada;

  void avancar() {
    final sobremesa = sobremesaSelecionada;

    if (sobremesa == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaPagamento(
          prato: widget.prato,
          bebida: widget.bebida,
          sobremesa: sobremesa,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final corPrincipal = Theme.of(context).colorScheme.primary;
    final estilos = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Sobremesa')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/icones/sobremesa.png',
                  width: 32,
                  height: 32,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text('Escolha a sobremesa', style: estilos.titleLarge),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: sobremesas.length,
                itemBuilder: (context, indice) {
                  final sobremesa = sobremesas[indice];
                  final selecionado = sobremesa == sobremesaSelecionada;

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: selecionado ? corPrincipal : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      leading: Image.asset(
                        'assets/icones/${icones[indice]}.png',
                        width: 40,
                        height: 40,
                      ),
                      title: Text(sobremesa.nome, style: estilos.titleMedium),
                      subtitle: Text(formatarValor(sobremesa.valor)),
                      trailing: selecionado
                          ? Image.asset(
                              'assets/icones/confirmado.png',
                              width: 28,
                              height: 28,
                            )
                          : null,
                      onTap: () {
                        setState(() {
                          sobremesaSelecionada = sobremesa;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: sobremesaSelecionada == null ? null : avancar,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Avançar'),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/icones/avancar.png',
                    width: 20,
                    height: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: Image.asset(
                      'assets/icones/voltar.png',
                      width: 20,
                      height: 20,
                    ),
                    label: const Text('Voltar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.popUntil(context, (rota) => rota.isFirst);
                    },
                    icon: Image.asset(
                      'assets/icones/inicio.png',
                      width: 20,
                      height: 20,
                    ),
                    label: const Text('Início'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
