import 'package:exercicio_4/models/item_cardapio.dart';
import 'package:exercicio_4/telas/tela_bebida.dart';
import 'package:exercicio_4/utils/formatar_valor.dart';
import 'package:flutter/material.dart';

class TelaPratoPrincipal extends StatefulWidget {
  const TelaPratoPrincipal({super.key});

  @override
  State<TelaPratoPrincipal> createState() => _TelaPratoPrincipalState();
}

class _TelaPratoPrincipalState extends State<TelaPratoPrincipal> {
  final List<ItemCardapio> pratos = const [
    ItemCardapio('Risoto de cogumelos', 39.90),
    ItemCardapio('Lasanha de berinjela', 36.50),
    ItemCardapio('Moqueca de banana-da-terra', 42.00),
  ];

  final List<String> icones = const ['risoto', 'lasanha', 'moqueca'];

  ItemCardapio? pratoSelecionado;

  void avancar() {
    final prato = pratoSelecionado;

    if (prato == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TelaBebida(prato: prato)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final corPrincipal = Theme.of(context).colorScheme.primary;
    final estilos = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Prato principal')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Image.asset('assets/icones/prato.png', width: 32, height: 32),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Escolha o prato principal',
                    style: estilos.titleLarge,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: pratos.length,
                itemBuilder: (context, indice) {
                  final prato = pratos[indice];
                  final selecionado = prato == pratoSelecionado;

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
                      title: Text(prato.nome, style: estilos.titleMedium),
                      subtitle: Text(formatarValor(prato.valor)),
                      trailing: selecionado
                          ? Image.asset(
                              'assets/icones/confirmado.png',
                              width: 28,
                              height: 28,
                            )
                          : null,
                      onTap: () {
                        setState(() {
                          pratoSelecionado = prato;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: pratoSelecionado == null ? null : avancar,
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
          ],
        ),
      ),
    );
  }
}
