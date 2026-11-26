"""
	PollisBritannica

An index of the articles of the Encyclopaedia Britannica, from the first edition (1768–1771) to the fourteenth (1929,
in its printings of 1929 and 1930), read from the scans of the Internet Archive, and the full text of each article: for each article, its edition, volume,
pages, headword, title, length in characters and the initials of its contributor. The index is this package's
artifact, downloaded by Pkg when the package is added or updated, and Pollis copies it into its built-in database
PollisBritannica; the texts are a second artifact, downloaded the first time `texts()` is called.

```julia
using PollisBritannica, DuckDB
con = DBInterface.connect(DuckDB.DB)
DBInterface.execute(con, "SELECT id, edition, title, chars FROM '\$(PollisBritannica.articles())' WHERE key = 'PETRA'")
DBInterface.execute(con, "SELECT text FROM '\$(PollisBritannica.texts())' WHERE id = 155160")
```
"""
module PollisBritannica

using Artifacts, LazyArtifacts

"""
The Parquet file of the articles, a row per article of each edition: `id` (by which `texts()` gives its text),
`edition`, `volume`, `item` (the Internet Archive item of the scan), `file` (the file of the volume, in an item that holds
several volumes), `printing` (in the fourteenth edition, 1929 or 1930,
where the copy's notice page shows it), `page` and `end_page` (the pages of the scan where the article starts and ends,
linked as `https://archive.org/details/<item>/<file>/page/n<page>`, without `<file>` in an item of one volume), `key` (the headword in
capital letters A to Z only, to look it up), `headword`, `title`, `chars` and `signature` (the contributor's initials,
where the article is signed).
"""
articles() = joinpath(artifact"britannica", "articles.parquet")

"""The Parquet file of the editions, a row per edition: `edition`, `label`, `years`, `volumes`, `articles` and `chars`."""
editions() = joinpath(artifact"britannica", "editions.parquet")

"""
The Parquet file of the texts, a row per article: its `id` in `articles()` and its `text`, a paragraph a line, as the
Internet Archive read it from the scan. It is downloaded the first time it is asked for, about 535 MB.
"""
texts() = joinpath(artifact"britannica_texts", "texts.parquet")

end
