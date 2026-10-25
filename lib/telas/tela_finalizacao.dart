import 'package:exercicio_4/models/item_cardapio.dart';
import 'package:exercicio_4/telas/tela_prato_principal.dart';
import 'package:exercicio_4/utils/formatar_valor.dart';
import 'package:flutter/material.dart';

class TelaFinalizacao extends StatelessWidget {
  final ItemCardapio prato;
  final ItemCardapio bebida;
  final ItemCardapio sobremesa;
  final String formaPagamento;

  const TelaFinalizacao({
    super.key,
    required this.prato,
    required this.bebida,
    required this.sobremesa,
    required this.formaPagamento,
  });

  static const Map<String, String> iconesPagamento = {
    'Pix': 'pix',
    'Cartão de crédito': 'credito',
    'Cartão de débito': 'debito',
    'Dinheiro': 'dinheiro',
  };

  void novoPedido(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const TelaPratoPrincipal()),
      (rota) => false,
    );
  }

  Widget linhaItem(String categoria, ItemCardapio item, TextTheme estilos) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  categoria,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 2),
                Text(item.nome, style: estilos.titleMedium),
              ],
            ),
          ),
          Text(formatarValor(item.valor), style: estilos.titleMedium),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final corPrincipal = Theme.of(context).colorScheme.primary;
    final estilos = Theme.of(context).textTheme;
    final total = prato.valor + bebida.valor + sobremesa.valor;

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Finalização do pedido'),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/icones/confirmado.png',
                    width: 32,
                    height: 32,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text('Pedido finalizado', style: estilos.titleLarge),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            linhaItem('PRATO PRINCIPAL', prato, estilos),
                            linhaItem('BEBIDA', bebida, estilos),
                            linhaItem('SOBREMESA', sobremesa, estilos),
                            const Divider(
                              height: 32,
                              thickness: 1,
                              color: Color(0xFFE5E7EB),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Total',
                                    style: estilos.titleLarge,
                                  ),
                                ),
                                Text(
                                  formatarValor(total),
                                  style: estilos.titleLarge?.copyWith(
                                    color: corPrincipal,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        leading: Image.asset(
                          'assets/icones/${iconesPagamento[formaPagamento]}.png',
                          width: 40,
                          height: 40,
                        ),
                        title: const Text(
                          'FORMA DE PAGAMENTO',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                        subtitle: Text(
                          formaPagamento,
                          style: estilos.titleMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => novoPedido(context),
                child: const Text('Novo pedido'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
