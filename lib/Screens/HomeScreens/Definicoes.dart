import 'package:flutter/material.dart';
import 'package:minimercado/Screens/HomeScreens/Login.dart';

import '../../utils/componentes/CustomAppBar.dart';
import '../../utils/componentes/InfAppBar.dart';

class DefinicoesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  ListTile(
                    title: Text('Termos e Condições'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TermosCondicoesScreen()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Política de Privacidade'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PoliticaPrivacidadeScreen()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Perguntas Frequentes'),
                    onTap: () {
                      // Ação para acessar as perguntas frequentes
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white38,
            ),
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Sair',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          InfAppBar(),
        ],
      ),
    );
  }
}

class TermosCondicoesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Termos e Condições'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Termos e Condições',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              '1. Introdução\n\n' +
                  'Bem-vindo aos Termos e Condições de Uso do App Médico! Estes termos regem o uso do nosso aplicativo móvel e serviços associados. Ao acessar ou utilizar nosso aplicativo, você concorda com estes termos e nossa Política de Privacidade.\n\n' +
                  '2. Uso do Aplicativo\n\n' +
                  'Você deve ter pelo menos 18 anos de idade para usar este aplicativo sem a permissão dos pais ou responsáveis. Você concorda em usar o aplicativo apenas para fins legais e de acordo com estes termos.\n\n' +
                  '3. Conteúdo e Propriedade Intelectual\n\n' +
                  'Todo o conteúdo disponibilizado através do aplicativo é protegido por direitos autorais e outras leis de propriedade intelectual. Você não pode modificar, copiar, distribuir, transmitir, exibir, realizar, reproduzir, publicar, licenciar, criar trabalhos derivados, transferir ou vender qualquer informação, software, produtos ou serviços obtidos através do nosso aplicativo sem nosso consentimento prévio por escrito.\n\n' +
                  '4. Privacidade\n\n' +
                  'Respeitamos sua privacidade e protegemos suas informações pessoais de acordo com nossa Política de Privacidade. Ao usar nosso aplicativo, você consente com a coleta e uso de suas informações conforme descrito na Política de Privacidade.\n\n' +
                  '5. Limitação de Responsabilidade\n\n' +
                  'O uso do nosso aplicativo é por sua conta e risco. Não nos responsabilizamos por danos diretos, indiretos, incidentais, consequenciais ou especiais resultantes do uso ou incapacidade de usar nosso aplicativo, mesmo que tenhamos sido avisados da possibilidade de tais danos.\n\n' +
                  '6. Alterações nos Termos\n\n' +
                  'Podemos revisar estes termos a qualquer momento sem aviso prévio. Ao continuar a usar nosso aplicativo após as alterações, você concorda em estar vinculado aos termos revisados.\n\n' +
                  '7. Disposições Gerais\n\n' +
                  'Estes termos constituem o acordo completo entre você e App Médico em relação ao uso do aplicativo. Se qualquer disposição destes termos for considerada inválida ou inexequível, essa disposição será limitada ou eliminada na medida mínima necessária, e as demais disposições destes termos permanecerão em pleno vigor e efeito.\n\n',
              style: TextStyle(fontSize: 16.0),
            ),
            // Adicione mais conteúdo conforme necessário
          ],
        ),
      ),
    );
  }
}

class PoliticaPrivacidadeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Política de Privacidade'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Política de Privacidade',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Proteger suas informações privadas é nossa prioridade. Esta Declaração de Privacidade se aplica ao [Nome do App Médico] e governa a coleta e uso de dados. Ao usar o [Nome do App Médico], você concorda com os termos desta Política de Privacidade.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Coleta de suas Informações Pessoais',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'O App Médico pode coletar informações pessoalmente identificáveis para fornecer e melhorar nossos serviços. Isso pode incluir informações como seu nome, endereço, número de telefone, endereço de e-mail e informações de pagamento, se você adquirir serviços através do aplicativo. Todas as informações coletadas são armazenadas de forma segura e usadas para garantir a qualidade do serviço e atender às suas necessidades.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Uso de suas Informações Pessoais',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Utilizamos suas informações pessoais para operar o aplicativo e fornecer os serviços solicitados. Isso pode incluir o uso de suas informações para verificar sua identidade, processar transações financeiras, responder a perguntas e fornecer suporte ao cliente. Periodicamente, podemos utilizar suas informações para informar sobre novos serviços ou produtos que possam ser do seu interesse.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Compartilhamento de suas Informações Pessoais',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'O App Médico pode compartilhar suas informações pessoais com terceiros apenas quando necessário para fornecer serviços essenciais, como processamento de pagamento, entrega de produtos ou suporte ao cliente. Garantimos que esses parceiros mantenham a confidencialidade de suas informações e as utilizem exclusivamente para fornecer serviços ao [Nome do App Médico].',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Segurança de suas Informações Pessoais',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Implementamos medidas de segurança para proteger suas informações pessoais contra acesso não autorizado ou alteração. Utilizamos tecnologias como criptografia para proteger a transmissão de dados sensíveis, como informações de pagamento.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Alterações nesta Declaração de Privacidade',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'O App Médico reserva-se o direito de alterar esta Política de Privacidade de tempos em tempos. Recomendamos que revise esta Declaração de Privacidade periodicamente para estar ciente de como estamos protegendo suas informações.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Contate-Nos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Se você tiver dúvidas ou preocupações sobre esta Política de Privacidade, entre em contato conosco através do seguinte endereço de e-mail: [email protected]',
              style: TextStyle(fontSize: 16.0),
            ),
            // Adicione mais conteúdo conforme necessário
          ],
        ),
      ),
    );
  }
}
