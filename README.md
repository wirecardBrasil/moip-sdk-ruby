# Moip v2 Ruby SDK

[![Build Status](https://travis-ci.org/moip/moip-sdk-ruby.svg?branch=master)](https://travis-ci.org/moip/moip-sdk-ruby)
[![Code Climate](https://codeclimate.com/github/moip/moip-sdk-ruby/badges/gpa.svg)](https://codeclimate.com/github/moip/moip-sdk-ruby)
[![Test Coverage](https://codeclimate.com/github/moip/moip-sdk-ruby/badges/coverage.svg)](https://codeclimate.com/github/moip/moip-sdk-ruby/coverage)

O jeito mais simples e rápido de integrar o Moip a sua aplicação Ruby

## Instalação

Adicione a seguinte linha no seu Gemfile:

```ruby
gem "moip2"
```

## Configurando sua autenticação
- Autenticando por BasicAuth
```ruby
auth = Moip2::Auth::Basic.new("TOKEN", "SECRET")
```
- Autenticando por OAuth
```ruby
auth = Moip2::Auth::OAuth.new("TOKEN_OAUTH")
```

Após deifinir o tipo de autenticação, é necessário gerar o client, informando em qual environment você quer executar suas ações:
```ruby
client = Moip2::Client.new(:sandbox/:production, auth)
```

Agora você pode instanciar a Api:
```ruby
api = Moip2::Api.new(client)
```

## Criando um Pedido

```ruby
order = api.order.create(
    {
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
    }
)
```

### Pedido com dados completos do Comprador

Agora basta criar o pedido:

```ruby
order = api.order.create(
    {
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
          birthdate: "1988-12-30",
          tax_document: { number: "33333333333", type: "CPF" },
          phone: { country_code: "55", area_code: "11", number: "66778899" },
          shipping_address: 
            {
              street: "Avenida Faria Lima",
              street_number: 2927,
              complement: 8,
              district: "Itaim",
              city: "Sao Paulo",
              state: "SP",
              country: "BRA",
              zip_code: "01234000"
            }
        }
    }
)
```

## Criando um pagamento

### Cartão de crédito com hash

```ruby
api.payment.create(order.id,
    {
        installment_count: 1,
        funding_instrument: {
            method: "CREDIT_CARD",
            credit_card: {
                hash: "valor do cartã criptografado vindo do JS",
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

### Cartão de crédito

```ruby
api.payment.create(order.id,
    {
        installment_count: 1,
        funding_instrument: {
            method: "CREDIT_CARD",
            credit_card: {
                expiration_month: 04,
                expiration_year: 18,
                number: "4012001038443335",
                cvc: "123",
                holder: {
                    fullname: "Jose Portador da Silva",
                    birthdate: "1988-10-10",
                    tax_document: {
                        type: "CPF",
                        number: "22222222222"
                },
                    phone: {
                        country_code: "55",
                        area_code: "11",
                        number: "55667788"
                    }
                }
            }
        }
    }
)
```

### Boleto

```ruby
api.payment.create(order.id,
    {
        funding_instrument: {
            method: "BOLETO",
            boleto: {
                expiration_date: "2015-09-30",
                instruction_lines: {
                    first: "Primeira linha do boleto",
                    second: "Segunda linha do boleto",
                    third: "Terceira linha do boleto"
                  },
                logo_uri: "https://"
            }
        }
    }
)
```
## Documentação

[Documentação oficial](https://moip.com.br/referencia-api/)

## Licença

[The MIT License](https://github.com/moip/moip-sdk-ruby/blob/master/LICENSE.txt)
