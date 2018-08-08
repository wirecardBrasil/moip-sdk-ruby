<img src="https://gist.githubusercontent.com/joaolucasl/00f53024cecf16410d5c3212aae92c17/raw/1789a2131ee389aeb44e3a9d5333f59cfeebc089/moip-icon.png" align="right" />

# Moip v2 Ruby SDK
> O jeito mais simples e rápido de integrar o Moip a sua aplicação Ruby

[![Build Status](https://travis-ci.org/moip/moip-sdk-ruby.svg?branch=master)](https://travis-ci.org/moip/moip-sdk-ruby)
[![Code Climate](https://codeclimate.com/github/moip/moip-sdk-ruby/badges/gpa.svg)](https://codeclimate.com/github/moip/moip-sdk-ruby)
[![Test Coverage](https://codeclimate.com/github/moip/moip-sdk-ruby/badges/coverage.svg)](https://codeclimate.com/github/moip/moip-sdk-ruby/coverage)

**Índice**

- [Instalação](#instalação)
- [Configurando a autenticação](#configurando-a-autenticação)
  - [Por BasicAuth](#por-basicauth)
  - [Por OAuth](#por-oauth)
- [Configurando o ambiente](#configurando-o-ambiente)
- [Exemplos de Uso](#clientes):
  - [Clientes](#clientes)
    - [Criação](#criação)
    - [Consulta](#consulta)
    - [Adicionar cartão de crédito](#adicionar-cartão-de-crédito)
    - [Deletar cartão de crédito](#deletar-cartão-de-crédito)
  - [Pedidos](#pedidos)
    - [Criação](#criação-1)
    - [Consulta](#consulta-1)
      - [Pedido Específico](#pedido-específico)
      - [Todos os Pedidos](#todos-os-pedidos)
        - [Sem Filtro](#sem-filtro)
        - [Com Filtros](#com-filtros)
        - [Com Paginação](#com-paginação)
        - [Consulta Valor Específico](#consulta-valor-específico)
  - [Pagamentos](#pagamentos)
    - [Criação](#criação-2)
      - [Cartão de Crédito](#cartão-de-crédito)
        - [Com Hash](#com-hash)
        - [Com Dados do Cartão](#com-dados-do-cartão)
      - [Com Boleto](#com-boleto)
    - [Consulta](#consulta-2)
    - [Capturar pagamento pré-autorizado](#capturar-pagamento-pré-autorizado)
    - [Cancelar pagamento pré-autorizado](#cancelar-pagamento-pré-autorizado)
  - [Reembolsos](#reembolsos)
    - [Criação](#criação-3)
      - [Valor Total](#valor-total)
      - [Valor Parcial](#valor-parcial)
    - [Consulta](#consulta-3)
  - [Multipedidos](#multipedidos)
    - [Criação](#criação-4)
    - [Consulta](#consulta-4)
  - [Multipagamentos](#multipagamentos)
    - [Criação](#criação-5)
    - [Consulta](#consulta-5)
    - [Capturar multipagamento pré-autorizado](#capturar-multipagamento-pré-autorizado)
    - [Cancelar multipagamento pré-autorizado](#cancelar-multipagamento-pré-autorizado)
  - [Conta Moip](#conta-moip)
    - [Criação](#criação-6)
    - [Consulta](#consulta-6)
    - [Verifica se usuário já possui Conta Moip](#verifica-se-usuário-já-possui-conta-moip)
  - [Conta Bancária](#conta-bancária)
    - [Criação](#criação-7)
    - [Consulta](#consulta-7)
    - [Listagem](#listagem)
    - [Atualizar conta bancária](#atualizar-conta-bancaria)
    - [Deletar conta bancária](#deletar-conta-bancaria)
  - [Transferência](#transferência)
    - [Criação](#criação-8)
      -[Conta Bancária](#conta-bancária)
      -[Conta Moip](#conta-moip-1)
    - [Consulta](#consulta-9)
    - [Listagem](#listagem-2)
    - [Reversão](#reversão)
  - [Custódia](#custódia)
    - [Pagamento com custódia](#pagamento-com-custódia)
    - [Liberação de custódia](#liberação-de-custódia)
  - [OAuth (Moip Connect)](#oauth-(moip-connect))
    - [Solicitar permissões de acesso ao usuário](#solicitar-permissões-de-acesso-ao-usuário)
    - [Gerar Token OAuth](#gerar-token-oauth)
    - [Atualizar Token OAuth](#atualizar-token-oauth)
    - [Obter Chave Pública](#obter-chave-pública)
  - [Preferências de Notificação](#preferências-de-notificação)
    -  [Criação](#criação-8)
    -  [Consulta](#consulta-8)
    -  [Exclusão](#exclusão)
    -  [Listagem](#listagem)
  - [Webhooks](#webhooks)
    - [Todos Webhooks](#todos-webhooks)
    - [Com Paginação](#com-paginação2)
    - [Evento Específico](#evento-específico)
    - [Recurso Específico](#recurso-específico)
  - [Saldo Moip](#saldo-moip)
    -  [Consulta](#consulta-10)
- [Tratamento de Exceções](#tratamento-de-exceções)
- [Documentação](#documentação)
- [Licença](#licença)
- [Comunidade Slack](#comunidade-slack-) [![Slack](https://user-images.githubusercontent.com/4432322/37355972-ba0e9f32-26c3-11e8-93d3-39917eb24109.png)](https://slackin-cqtchmfquq.now.sh)


## Instalação

Adicione a seguinte linha no seu Gemfile:

```ruby
gem "moip2"
```

## Configurando a autenticação
### Por BasicAuth
```ruby
auth = Moip2::Auth::Basic.new("TOKEN", "SECRET")
```
### Por OAuth
```ruby
auth = Moip2::Auth::OAuth.new("TOKEN_OAUTH")
```

## Configurando o ambiente
Após definir o tipo de autenticação, é necessário gerar o client, informando em qual ambiente você quer executar suas ações:
```ruby
client = Moip2::Client.new(:sandbox/:production, auth)
```

Após isso, é necessário instanciar um ponto de acesso a partir do qual você utilizará as funções da API:

```ruby
api = Moip2::Api.new(client)
```

Você pode customizar o client passando um hash de opções na inicialização. Essas opções serão passadas adiante para o client HTTParty, que aceita as opções descritas [na documentação](http://www.rubydoc.info/github/jnunemaker/httparty/HTTParty/ClassMethods).

Por exemplo, para alterar o timeout das requisições para 5 segundos:
```ruby
client = Moip2::Client.new(:sandbox/:production, auth, timeout: 5)
```

## Clientes
### Criação
```ruby
customer = api.customer.create({
  ownId: "meu_id_de_cliente",
  fullname: "Jose Silva",
  email: "josedasilva@email.com",
  phone: {
    #...
  },
  birthDate: "1988-12-30",
  taxDocument: {
    #...
  },
  shippingAddress: {
    #...
  },
  fundingInstrument: {
    # Campo opcional. Consulte a documentação da API.
  }
})
```
### Consulta
```ruby
customer = api.customer.show("CUS-V41BR451L")
```

### Adicionar cartão de crédito
```ruby
credit_card = api.customer.add_credit_card("CUSTOMER-ID",
    {
      method: "CREDIT_CARD",
      creditCard: {
        expirationMonth: "05",
        expirationYear: "22",
        number: "5555666677778884",
        cvc: "123",
        holder: {
          fullname: "Jose Portador da Silva",
          birthdate: "1988-12-30",
          taxDocument: {
            type: "CPF",
            number: "33333333333",
          },
          phone: {
            countryCode: "55",
            areaCode: "11",
            number: "66778899",
          },
        },
      },
    }
)
```

### Deletar cartão de crédito

> Retorna uma Exception do tipo `NotFoundError` caso não encontre o cartão de crédito para deletar.

```ruby
api.customer.delete_credit_card!("CREDIT-CARD-ID")
```

## Pedidos
### Criação

```ruby
order = api.order.create({
  own_id: "ruby_sdk_1",
  items: [
    {
      product: "Nome do produto",
      quantity: 1,
      detail: "Mais info...",
      price: 1000
    }
  ],
  customer: {
    own_id: "ruby_sdk_customer_1",
    fullname: "Jose da Silva",
    email: "sandbox_v2_1401147277@email.com",
  }
})
```
### Consulta
#### Pedido Específico
```ruby
order = api.order.show("ORD-V41BR451L")
```

#### Todos os Pedidos
##### Sem Filtro
```ruby
orders = api.order.find_all()
```

##### Com Filtros
```ruby
orders = api.order.find_all(filters: { status: { in: ["PAID", "WAITING"] }, amount: { bt: [500, 1000] } })
```

##### Com Paginação
```ruby
orders = api.order.find_all(limit: 10, offset: 50)
```

##### Consulta Valor Específico
```ruby
orders = api.order.find_all(q: "your_value")
```

## Pagamentos

### Criação
#### Cartão de Crédito
##### Com Hash

```ruby
api.payment.create(order.id,
    {
        installment_count: 1,
        funding_instrument: {
            method: "CREDIT_CARD",
            credit_card: {
                hash: "valor do cartão criptografado vindo do JS",
                holder: {
                    fullname: "Jose Portador da Silva",
                    birthdate: "1988-10-10",
                    tax_document: {
                        type: "CPF",
                        number: "22222222222"
                    }
                }
            }
        }
    }
)
```

##### Com Dados do Cartão
> Esses método requer certificação PCI. [Consulte a documentação.](https://documentao-moip.readme.io/v2.0/reference#criar-pagamento)

```ruby
api.payment.create(order.id,
    {
        installment_count: 1,
        funding_instrument: {
            method: "CREDIT_CARD",
            credit_card: {
                expiration_month: 04,
                expiration_year: 18,
                number: "4002892240028922",
                cvc: "123",
                holder: {
                    # ...
                }
            }
        }
    }
)
```

#### Com Boleto

```ruby
api.payment.create(order.id,
    {
      # ...
        funding_instrument: {
            method: "BOLETO",
            boleto: {
                expiration_date: "2017-09-30",
                instruction_lines: {
                    first: "Primeira linha do boleto",
                    second: "Segunda linha do boleto",
                    third: "Terceira linha do boleto"
                  },
                logo_uri: "https://sualoja.com.br/logo.jpg"
            }
        }
    }
)
```

### Consulta
```ruby
pagamento = api.payment.show("PAY-CRUP19YU2VE1")
```

### Capturar pagamento pré-autorizado
```ruby
api.payment.capture("PAY-KT5OSI01X8QU")
```

### Cancelar pagamento pré-autorizado
```ruby
api.payment.void("PAY-IXNGCU456GG4")
```

## Reembolsos
### Criação
#### Valor Total
```ruby
reembolso = api.refund.create("ORD-V41BR451L")
```
#### Valor Parcial
```ruby
reembolso = api.refund.create("ORD-V41BR451L", amount: 2000)
```

### Consulta
```ruby
reembolso = api.refund.show("REF-V41BR451L")
```

## Multipedidos
### Criação
```ruby
multi = api.multi_order.create(
  {
    ownId: "meu_multiorder_id",
    orders: [
      {
        # Objeto Order 1
      },
      {
        # Objeto Order 2
      }
    ]
  }
)
```
### Consulta
```ruby
multi = api.multi_order.show("MOR-V41BR451L")
```
### Nota
> 1. Essa função depende de permissões das contas associadas ao recebimento.  [Consulte a documentação.](https://documentao-moip.readme.io/v2.0/reference#multipedidos)
> 2. Para reembolsos de multipedidos, é necessario reembolsar os pedidos individualmente. [Consulte a documentação.](https://documentao-moip.readme.io/v2.0/reference#multipedidos)

## Multipagamentos
### Criação
```ruby
multi_pag = api.multi_payment.create("MOR-V41BR451L",
  {
    installmentCount: 1,
    fundingInstrument: {
      # ...
    }
  }
)
```
### Consulta
```ruby
multi_pag = api.multi_payment.show("MPY-V41BR451L")
```

### Capturar multipagamento pré-autorizado
```ruby
multi = api.multi_payment.capture("MPY-V41BR451L")
```
### Cancelar multipagamento pré-autorizado
```ruby
multi = api.multi_payment.void("MPY-V41BR451L")
```

## Conta Moip
### Criação
```ruby
account = api.accounts.create(
  {
    email: {
      address: "dev.moip@labs.moip.com.br",
    },
    person: {
      name: "Joaquim José",
      lastName: "Silva Silva",
      taxDocument: {
        type: "CPF",
        number: "572.619.050-54",
      },
      identityDocument: {
        type: "RG",
        number: "35.868.057-8",
        issuer: "SSP",
        issueDate: "2000-12-12",
      },
      birthDate: "1990-01-01",
      phone: {
        countryCode: "55",
        areaCode: "11",
        number: "965213244",
      },
      address: {
        street: "Av. Brigadeiro Faria Lima",
        streetNumber: "2927",
        district: "Itaim",
        zipCode: "01234-000",
        city: "S\u00E3o Paulo",
        state: "SP",
        country: "BRA",
      },
    },
    type: "MERCHANT"
  }
)
```

### Consulta
```ruby
account = api.accounts.show("MPA-12312312312")
```

### Verifica se usuário já possui Conta Moip
```ruby
api.accounts.exists?({tax_document: "123.456.789.10"})
```

### ou
```ruby
api.accounts.exists?({email: "dev.moip@labs.moip.com.br"})
```

## Conta bancária
### Criação
```ruby
bank_account = api.bank_accounts.create("MPA-14C9EE706C55",
      bank_number: "237",
      agency_number: "12345",
      agency_check_number: "0",
      account_number: "12345678",
      account_check_number: "7",
      type: "CHECKING",
      holder: {
        tax_document: {
          type: "CPF",
          number: "164.664.426-32",
        },
        fullname: "Sales Machine da Silva",
      })
```

### Consulta
```ruby
api.bank_accounts.show("BKA-DWTSK16UQI9N")
```

### Listagem
```ruby
api.bank_accounts.find_all("MPA-14C9EE706C55")
```

### Atualizar conta bancaria
```ruby
api.bank_accounts.update("BKA-DWTSK16UQI9N",
      bank_number: "237",
      agency_number: "12345",
      agency_check_number: "0",
      account_number: "87654323",
      account_check_number: "7",
      type: "CHECKING",
      holder: {
        tax_document: {
          type: "CPF",
          number: "164.664.426-32",
        },
        fullname: "Sales Machine da Silva",
      })
```

### Deletar conta bancaria
> Retorna uma Exception do tipo `NotFoundError` caso não encontre a conta bancária para deletar
```ruby
  api.bank_accounts.delete("BKA-DWTSK16UQI9N")
```

## Transferência
### Criação
#### Conta Bancária
```ruby
transfer = api.transfer.create(
  amount: 500,
  transferInstrument: {
    method: "BANK_ACCOUNT",
    bankAccount: {
      type: "CHECKING",
      bankNumber: "001",
      agencyNumber: "1111",
      agencyCheckNumber: "2",
      accountNumber: "9999",
      accountCheckNumber: "8",
      holder: {
        fullname: "Nome do Portador",
        taxDocument: {
          type: "CPF",
          number: "22222222222",
        },
      },
    },
  },
)
```


#### Conta Moip
```ruby
transfer = api.transfer.create(
  amount: 500,
  transferInstrument: {
    method: "MOIP_ACCOUNT",
    moipAccount: {
      id: "MPA-B0D880F21EF1",
    },
  },
)
```

### Consulta
```ruby
transfer = api.transfer.show("TRA-28HRLYNLMUFH")
```

### Listagem
```ruby
transfers = api.transfer.find_all()
```

### Reversão
```ruby
transfer = api.transfer.reverse("TRA-B0W5FD5FCADG")
```
## Custódia
### Pagamento com custódia
```ruby
payment = api.payment.create(order.id,
    {
        installment_count: 1,
        escrow: {
          description: 'Custódia de pagamento'
        },
        funding_instrument: {
            method: "CREDIT_CARD",
            credit_card: {
                expiration_month: 04,
                expiration_year: 18,
                number: "4002892240028922",
                cvc: "123",
                holder: {
                    # ...
                }
            }
        }
    }
)
```

### Liberação de custódia
```ruby
escrow = api.payment.release("ECW-JO3U4WIXD0CK")
```

## OAuth (Moip Connect)
### Solicitar permissões de acesso ao usuário
```ruby
api.connect.authorize_url("APP-ID","http://localhost/moip/callback","RECEIVE_FUNDS,REFUND")
```

### Gerar token OAuth
```ruby
api.connect.authorize(
  client_id: "APP-YRYCCJ5P603B",
  client_secret: "363cdf8ab70a4c5aa08017564c08efbe",
  code: "4efde1f89d9acc3b12124ccfded146518465e423",
  redirect_uri: "http://localhost/moip/callback",
  grant_type: "authorization_code"
)
```

### Atualizar token OAuth
```ruby
api.connect.authorize(
  refresh_token: "1d5dc51e71674683b4ed79cd7a988fa1_v2",
  grant_type: "refresh_token"
)
```

### Obter Chave Pública
```ruby
keys = api.keys.show
```

## Preferências de notificação

### Criação
```ruby
api.notifications.create(
  events: ["ORDER.*", "PAYMENT.AUTHORIZED", "PAYMENT.CANCELLED"],
  target: "http://requestb.in/1dhjesw1",
  media: "WEBHOOK"
)
```

### Consulta
```ruby
api.notifications.show("NOTIFICATION-ID")
```

### Exclusão
> Caso o notification não seja encontrado uma exceção do tipo `NotFoundError` será lançada, veja como tratar [aqui](#tratamento-de-exceções).

```ruby
api.notifications.delete("NOTIFICATION-ID")
```

### Listagem
```ruby
api.notifications.find_all
```

## Webhooks
### Consulta

##### Todos Webhooks
```ruby
webhooks = api.webhooks.find_all
```

##### Com Paginação
```ruby
webhooks = api.webhooks.find_all(limit: 10, offset: 50)
```

##### Consulta Evento
```ruby
webhooks = api.webhooks.find_all(event: "PAYMENT.WAITING")
```

##### Consulta Valor Específico
```ruby
webhooks = api.webhooks.find_all(resource_id: "PAY-REJJ9F12MF7R")
```


## Saldo Moip
### Consulta
```ruby
api.balances.show()
```

### Show all entries
```ruby
  api.entries.find_all
```
### Show one entry
```ruby
  api.entries.show(entry_id)
```
## Tratamento de Exceções

Caso algum recurso não seja encontrado uma exceção do tipo `NotFoundError` será lançada.

```ruby
begin
  api.payment.create(
    # ...
  )
rescue NotFoundError => e
  puts e.message
end
```

## Documentação

[Documentação oficial](https://moip.com.br/referencia-api/)

## Licença

[The MIT License](https://github.com/moip/moip-sdk-ruby/blob/master/LICENSE.txt)

## Comunidade Slack [![Slack](https://user-images.githubusercontent.com/4432322/37355972-ba0e9f32-26c3-11e8-93d3-39917eb24109.png)](https://slackin-cqtchmfquq.now.sh)

Tem dúvidas? Fale com a gente no [Slack](https://slackin-cqtchmfquq.now.sh/)!
