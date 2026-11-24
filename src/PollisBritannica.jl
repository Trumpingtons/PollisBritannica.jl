"""
	PollisBritannica

An index of the articles of the Encyclopaedia Britannica, from the first edition (1768–1771) to the fourteenth (1929),
read from the scans of the Internet Archive: for each article, its edition, volume, page, headword, title, length in
characters, the initials of its contributor and its opening words. The files are this package's artifact, downloaded
by Pkg when the package is added or updated, and Pollis copies them into its built-in database PollisBritannica.

```julia
using PollisBritannica, DuckDB
DBInterface.execute(DBInterface.connect(DuckDB.DB), "SELECT edition, title, chars FROM '\$(PollisBritannica.articles())' WHERE key = 'PETRA'")
```
"""
module PollisBritannica

using Artifacts

"""
The Parquet file of the articles, a row per article of each edition: `edition`, `volume`, `item` (the Internet Archive
item of the scan), `page` (the page of the scan where the article starts, linked as
`https://archive.org/details/<item>/page/n<page>`), `key` (the headword in capital letters A to Z only, to look it up),
`headword`, `title`, `chars`, `signature` (the contributor's initials, where the article is signed) and `opening`.
"""
articles() = joinpath(artifact"britannica", "articles.parquet")

"""The Parquet file of the editions, a row per edition: `edition`, `label`, `years`, `volumes`, `articles` and `chars`."""
editions() = joinpath(artifact"britannica", "editions.parquet")

"""The TOML file of the cases: articles followed through the editions, with what changes from one to the next."""
cases() = joinpath(artifact"britannica", "cases.toml")

end
