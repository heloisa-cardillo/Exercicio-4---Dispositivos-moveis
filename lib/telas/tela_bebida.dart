import 'package:exercicio_4/models/item_cardapio.dart';
import 'package:exercicio_4/telas/tela_sobremesa.dart';
import 'package:exercicio_4/utils/formatar_valor.dart';
import 'package:flutter/material.dart';

class TelaBebida extends StatefulWidget {
  final ItemCardapio prato;

  const TelaBebida({super.key, required this.prato});

  @override
  State<TelaBebida> createState() => _TelaBebidaState();
}

class _TelaBebidaState extends State<TelaBebida> {
  final List<ItemCardapio> bebidas = const [
    ItemCardapio('Suco de laranja', 9.50),
    ItemCardapio('Suco de maracujá', 9.90),
    ItemCardapio('Suco de abacaxi com hortelã', 10.50),
  ];

  final List<String> icones = const [
    'suco_laranja',
    'suco_maracuja',
    'suco_abacaxi',
  ];

  ItemCardapio? bebidaSelecionada;

  void avancar() {
    final bebida = bebidaSelecionada;

    if (bebida == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            TelaSobremesa(prato: widget.prato, bebida: bebida),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final corPrincipal = Theme.of(context).colorScheme.primary;
    final estilos = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Bebida')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Image.asset('assets/icones/bebida.png', width: 32, height: 32),
                const SizedBox(width: 12),
                Expanded(
                  child: Text('Escolha a bebida', style: estilos.titleLarge),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: bebidas.length,
                itemBuilder: (context, indice) {
                  final bebida = bebidas[indice];
                  final selecionado = bebida == bebidaSelecionada;

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
                      title: Text(bebida.nome, style: estilos.titleMedium),
                      subtitle: Text(formatarValor(bebida.valor)),
                      trailing: selecionado
                          ? Image.asset(
                              'assets/icones/confirmado.png',
                              width: 28,
                              height: 28,
                            )
                          : null,
                      onTap: () {
                        setState(() {
                          bebidaSelecionada = bebida;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: bebidaSelecionada == null ? null : avancar,
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
