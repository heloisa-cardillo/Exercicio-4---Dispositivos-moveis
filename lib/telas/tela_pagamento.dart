import 'package:exercicio_4/models/item_cardapio.dart';
import 'package:exercicio_4/telas/tela_finalizacao.dart';
import 'package:flutter/material.dart';

class TelaPagamento extends StatefulWidget {
  final ItemCardapio prato;
  final ItemCardapio bebida;
  final ItemCardapio sobremesa;

  const TelaPagamento({
    super.key,
    required this.prato,
    required this.bebida,
    required this.sobremesa,
  });

  @override
  State<TelaPagamento> createState() => _TelaPagamentoState();
}

class _TelaPagamentoState extends State<TelaPagamento> {
  final List<String> formas = const [
    'Pix',
    'Cartão de crédito',
    'Cartão de débito',
    'Dinheiro',
  ];

  final List<String> icones = const ['pix', 'credito', 'debito', 'dinheiro'];

  String? formaSelecionada;

  void avancar() {
    final forma = formaSelecionada;

    if (forma == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaFinalizacao(
          prato: widget.prato,
          bebida: widget.bebida,
          sobremesa: widget.sobremesa,
          formaPagamento: forma,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final corPrincipal = Theme.of(context).colorScheme.primary;
    final estilos = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Forma de pagamento')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/icones/pagamento.png',
                  width: 32,
                  height: 32,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Escolha a forma de pagamento',
                    style: estilos.titleLarge,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: formas.length,
                itemBuilder: (context, indice) {
                  final forma = formas[indice];
                  final selecionado = forma == formaSelecionada;

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
                      title: Text(forma, style: estilos.titleMedium),
                      trailing: selecionado
                          ? Image.asset(
                              'assets/icones/confirmado.png',
                              width: 28,
                              height: 28,
                            )
                          : null,
                      onTap: () {
                        setState(() {
                          formaSelecionada = forma;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: formaSelecionada == null ? null : avancar,
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
