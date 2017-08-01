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
  - [Pedidos](#pedidos)
    - [Criação](#criação-1)
    - [Consulta](#consulta-1)
  - [Pagamentos](#pagamentos)
    - [Cartão de Credito](#cartão-de-credito)
      - [Com Hash](#com-hash)
      - [Com Dados do Cartão](#com-dados-do-cartão)
      - [Com boleto](#com-boleto)
  - [Reembolsos](#reembolsos)
    - [Criação](#criação-2)
      - [Valor Total](#valor-total)
      - [Valor Parcial](#valor-parcial)
    - [Consulta](#consulta-2)
  - [Multipedidos](#multipedidos)
    - [Criação](#criação-3)
    - [Consulta](#consulta-3)
  - [Multipagamentos](#multipagamentos)
    - [Criação](#criação-4)
    - [Consulta](#consulta-4)
- [Documentação](#documentação)
- [Licença](#licença)


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

## Clientes
### Criação
```ruby
customer = api.customer.create(
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
        },
      }
)
```
### Consulta
```ruby
customer = api.customer.show("CUS-V41BR451L")
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
```ruby
order = api.order.show("ORD-V41BR451L")
```

## Pagamentos
### Cartão de Credito 
#### Com Hash

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

#### Com Dados do Cartão 
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

#### Com boleto

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


## Documentação

[Documentação oficial](https://moip.com.br/referencia-api/)

## Licença

[The MIT License](https://github.com/moip/moip-sdk-ruby/blob/master/LICENSE.txt)

