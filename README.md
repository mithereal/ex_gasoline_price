# GasolinePrice

** Fetch gas rates from gasprices.aaa.com**

[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/gasoline_price/)
[![Hex.pm](https://img.shields.io/hexpm/dt/gasoline_price.svg)](https://hex.pm/packages/gasoline_price)
[![License](https://img.shields.io/hexpm/l/gasoline_price.svg)](https://github.com/mithereal/ex_gasoline_price/blob/master/LICENSE)
[![Last Updated](https://img.shields.io/github/last-commit/mithereal/ex_gasoline_price.svg)](https://github.com/mithereal/ex_gasoline_price/commits/master)
[![Build Status](https://circleci.com/gh/mithereal/ex_gasoline_price.svg?style=svg)](https://github.com/mithereal/ex_gasoline_price)
[![Coverage Status](https://coveralls.io/repos/github/mithereal/ex_gasoline_price/badge.svg?branch=main)](https://coveralls.io/github/mithereal/ex_gasoline_price?branch=main)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `gasolineprice` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:gasoline_price, "~> 0.3.1"}
  ]
end
```

## Usage

```elixir
iex>  GasolinePrice.fetch_national_avg()

iex>  GasolinePrice.fetch_avg_rates("AZ")
```

## Standalone

One can create a standalone app via 

```bash
MIX_ENV=cli && mix deps.get && mix release
cp _build/cli/rel/bakeware/gasoline_price /usr/local/bin/.
gasoline_price "CA"
{"diesel":6.754,"mid":6.423,"premium":6.561,"regular":6.246}

gasoline_price fetch_metro_rates "CA"
[...]
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/gasoline_price](https://hexdocs.pm/gasoline_price).

