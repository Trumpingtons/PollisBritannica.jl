# PollisBritannica.jl

An index of the articles of the Encyclopaedia Britannica in every edition from the first, of 1768 to 1771, to the fourteenth, of 1929, in its printings of 1929 and 1930, with the full text of each article, read from the scans of the [Internet Archive](https://archive.org), for the built-in database PollisBritannica of [Pollis](https://pollis.org) and its page Britannica Through the Editions.

The files are the package's two artifacts. Pkg downloads the index, about 4 MB, when the package is added or updated; the texts, about 535 MB, are downloaded the first time they are asked for:

```julia
using PollisBritannica
PollisBritannica.articles()  # the path of articles.parquet
PollisBritannica.editions()  # the path of editions.parquet
PollisBritannica.texts()     # the path of texts.parquet, downloaded the first time
```

Pollis installs the package, keeps it up to date with GitHub, and copies the index into the tables of PollisBritannica; its page reads the text of an article from `texts.parquet`.

## articles.parquet

One row per article of each edition.

| Column | |
|---|---|
| `id` | the article's number, by which `texts.parquet` gives its text |
| `edition` | `1` to `14`, and `3S` and `6S` for the supplements of 1801 and 1815–1824 |
| `volume` | the volume, with `a` or `b` for the two parts of a volume bound apart; in the fourteenth edition, `.2`, `.3` and so on for the second and further copies of a volume |
| `item`, `page`, `end_page` | the item of the Internet Archive and the pages of its scan where the article starts and ends: `https://archive.org/details/<item>/page/n<page>`; no pages for the scans without a page index |
| `printing` | in the fourteenth edition, the printing of the copy, 1929 or 1930, the last year of the copyright notice on the back of its title page; empty for a copy whose notice page is missing, and for the other editions |
| `key` | the headword in the capital letters A to Z only, to look an article up in every edition |
| `headword`, `title` | the headword, and the title with its qualifiers, as the scan reads them |
| `chars` | the length of the article in characters, as the scan reads it; its text in `texts.parquet`, without the running heads and page numbers, is a little shorter |
| `signature` | the initials of the contributor, where the article is signed |

## texts.parquet

One row per article: its `id` and its `text`, a paragraph a line. The running heads and page numbers of the scan are left out, the words hyphenated at the end of a line are joined, and a paragraph cut by a page break is joined again. The plates, maps and figures are not in the text: the pages of the scan show them.

## editions.parquet

One row per edition: `edition`, `label`, `years`, `volumes`, `articles` and `chars`, the characters of all its articles. The tenth, twelfth and thirteenth editions are new volumes added to the edition before them, and only those volumes are in it.

## How the articles are found

A headword opens a paragraph, or follows the full stop of the article before it, in capitals, followed by a comma, a bracket, a full stop or a dash. Of the headwords found in a volume, the longest sequence in alphabetical order is kept, which leaves out the running heads of the pages and the capitals within articles; the early editions, which file I with J and U with V, are read in their own order. An article runs to the next headword, and its signature is the initials in brackets at its end. The fourteenth edition is read from several copies of some volumes, and each headword is taken from the copy with the most of its text.

The fourteenth edition was reprinted, and revised, many times after 1929, and the copyright notice of each printing lists the years of its revisions ("Copyright in the United States of America, 1929, 1930, 1932, ..."). Only copies of the printings of 1929 and 1930 are read. A copy whose notice page is missing is read when its text mentions the years after 1930 no more often than the copies of 1929 and 1930 do. No copy of volume 18 of these printings holds more than a part of the volume.

The text is the one the Internet Archive read from each scan: a headword misread by the scan may be missing, so that its article runs into the one before, and titles and initials may carry misread letters. The page of the scan shows each article as printed.

The text of the fourteenth edition is compared across the copies of its volume. The same article in each other copy is aligned with it word by word, and each word takes the reading most copies share; where they are split evenly, an English word is taken before a word unknown to the word list, and a year before 1931 before a later one. A year from 1931 to 1939, which no printing of 1929 or 1930 can name, is read ten years earlier unless a second copy reads it too: the scans often read a 2 of the old-style figures as a 3. The texts of the other editions, each read from one copy, are as the scan reads them.

## Licence

The package code is MIT licensed. The index holds what is measured of each article, with the link to its scan, and the texts are those the Internet Archive read from the scans; the scans are those of the Internet Archive and of the libraries that hold the volumes, among them the National Library of Scotland and the Digital Library of India.
