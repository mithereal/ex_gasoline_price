# Gasrate

** Fetch gas rates from gasprices.aaa.com**

[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/gasrate/)
[![Hex.pm](https://img.shields.io/hexpm/dt/gasrate.svg)](https://hex.pm/packages/gasrate)
[![License](https://img.shields.io/hexpm/l/gasrate.svg)](https://github.com/mithereal/ex_gasrate/blob/master/LICENSE)
[![Last Updated](https://img.shields.io/github/last-commit/mithereal/ex_gasrate.svg)](https://github.com/mithereal/ex_gasrate/commits/master)
[![Build Status](https://circleci.com/gh/mithereal/ex_gasrate.svg?style=svg)](https://github.com/mithereal/ex_gasrate)


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `gasrate` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:gasrate, "~> 0.3.0"}
  ]
end
```

## Usage

```elixir
iex>  Gasrate.fetch_national_avg()

iex>  Gasrate.fetch_avg_rates("AZ")
```

## Standalone

One can create a standalone app via 

```bash
MIX_ENV=cli && mix deps.get && mix release
cp _build/cli/rel/bakeware/gas_rate /usr/local/bin/.
gas_rate "CA"
{"diesel":6.754,"mid":6.423,"premium":6.561,"regular":6.246}
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/gasrate](https://hexdocs.pm/gasrate).

