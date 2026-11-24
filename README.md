# PollisBritannica.jl

An index of the articles of the Encyclopaedia Britannica in every edition from the first, of 1768 to 1771, to the fourteenth, of 1929, read from the scans of the [Internet Archive](https://archive.org), for the built-in database PollisBritannica of [Pollis](https://pollis.org) and its page Britannica Through the Editions.

The files are the package's artifact, which Pkg downloads when the package is added or updated:

```julia
using PollisBritannica
PollisBritannica.articles()  # the path of articles.parquet
PollisBritannica.editions()  # the path of editions.parquet
PollisBritannica.cases()     # the path of cases.json
```

Pollis installs the package, keeps it up to date with GitHub, and copies the files into the tables of PollisBritannica.

## articles.parquet

One row per article of each edition.

| Column | |
|---|---|
| `edition` | `1` to `14`, and `3S` and `6S` for the supplements of 1801 and 1815–1824 |
| `volume` | the volume, with `a` or `b` for the two parts of a volume bound apart |
| `item`, `page` | the item of the Internet Archive and the page of its scan where the article starts: `https://archive.org/details/<item>/page/n<page>`; no page for the scans without a page index |
| `key` | the headword in the capital letters A to Z only, to look an article up in every edition |
| `headword`, `title` | the headword, and the title with its qualifiers, as the scan reads them |
| `chars` | the length of the article in characters |
| `signature` | the initials of the contributor, where the article is signed |
| `opening` | the first 300 characters of the article |

## editions.parquet

One row per edition: `edition`, `label`, `years`, `volumes`, `articles` and `chars`, the characters of all its articles. The tenth, twelfth and thirteenth editions are new volumes added to the edition before them, and only those volumes are in it.

## cases.json

Articles followed through the editions, one row per edition of each case: `id`, `name` and `summary` of the case, `edition`, the `key` and `article` (a pattern of the title) of the article it follows there, and a `note` on what changed. The cases are Petra, Charles Darwin, Evolution and Alexander von Humboldt; their source is `data/cases.toml`.

## How the articles are found

A headword opens a paragraph, or follows the full stop of the article before it, in capitals, followed by a comma, a bracket, a full stop or a dash. Of the headwords found in a volume, the longest sequence in alphabetical order is kept, which leaves out the running heads of the pages and the capitals within articles; the early editions, which file I with J and U with V, are read in their own order. An article runs to the next headword, and its signature is the initials in brackets at its end. The fourteenth edition is read from several copies of some volumes, and each headword is taken from the copy with the most of its text.

The text is the one the Internet Archive read from each scan: a headword misread by the scan may be missing, so that its article runs into the one before, and titles and initials may carry misread letters. The page of the scan shows each article as printed.

## Licence

The package code is MIT licensed. The index holds what is measured of each article and its first words, with the link to its scan; the scans and their text are those of the Internet Archive and of the libraries that hold the volumes, among them the National Library of Scotland and the Digital Library of India.
