Diane [![Build Status](https://travis-ci.org/ptrckbrwn/diane.svg)](https://travis-ci.org/ptrckbrwn/diane)
=====

RSS/Atom parser for Elixir.

:warning: Very early stages of development. :warning:

## Documentation

```elixir
raw_xml = "..." # Feed in raw string form.
{:ok, feed} = Diane.parse(raw_xml)

channel = feed.channels |> List.first
channel.title
# xkcd.com

channel.description
# xkcd.com: A webcomic of romance and math humor.

channel.items |> Enum.map(fn(item) -> item.title end)
# ['Keyboard Mash', 'Vodka', ...]
```

## TODO

- [x] RSS 2.0 feed parsing
- [ ] RSS 1.x feed parsing
- [ ] Atom feed parsing
- [x] Logic to determine what kind of feed to parse.

## Goals

1. 100% Elixir RSS/Atom parser.
2. Super fast.
3. Adhere to RSS/Atom specs.
  1. [RSS Spec](http://cyber.law.harvard.edu/rss/rss.html)
  2. [Atom Spec](https://tools.ietf.org/html/rfc4287)
