# Moip v2 Ruby SDK

O jeito mais simples e rápido de integrar o Moip a sua aplicação Ruby

## Instalação

Adicionar a seguinte linha no seu Gemfile:

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

## Criando um Pedido

Agora basta criar o pedido:

```ruby
Moip2::OrderApi.new(client).create(
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

## Criando um pagamento

### Cartão de crédito

```ruby
Moip2::PaymentApi.new(client).create(
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
Moip2::PaymentApi.new(client).create(
    {
        fundingInstrument: {
            method: "BOLETO",
            boleto: {
                expirationDate: "2015-09-30",
                instructionLines: {
                    first: "Primeira linha do boleto",
                    second: "Segunda linha do boleto",
                    third: "Terceira linha do boleto"
                  },
                "logoUri": "https://"
            }
        }
    }
)
```
## Documentação

[Documentação ofcial](https://moip.com.br/referencia-api/)

## Licença

[The MIT License](https://github.com/moip/php-sdk/blob/master/LICENSE)
