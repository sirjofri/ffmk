ffmk — a farbfeld recipe parser
===============================

![demo image](result.png)

This perl script is able to parse a specific input file (see `demo.fm` for
syntax) and call the farbfeld tools specified. It is possible to include
mathematical expressions (inside `[]`) and use variables. These variables are
simple text replacements and are replaced before the mathematical expressions.

Usage
-----

The program receives a recipe file via `STDIN`. You can choose the output
style:

**1\. Output directly to files.** With the `--files` flag you can tell the
tool to output all targets to their own files (called `<target>.ff`).

**2\. Output to STDOUT.** The default behaviour is to output the targets to
`STDOUT`. The format is like this:
`target:farbfeld<binary-data>dlefbraf:target:farbfeld<binary-data>dlefbraf...`

You can also treat the resulting data stream as input for the `ffextract`
script. This script can extract the image channels and extract one to `STDOUT`
or more to files (`--files`).

Output EBNF
-----------

This information can help you write a parser/filter program. For more
information about farbfeld see the [official
site](https://tools.suckless.org/farbfeld/).

```
Output = Record | ( Record, Output ) ;
Record = Target, ":", FarbfeldData, MagicReverse, ":" ;
Target = AlphaNumeric ;
MagicReverse = "dlefbraf" ;

FarbfeldData = Magic, Width, Height, ImageData ;
Magic = "farbfeld" ;
ImageData = { Red, Green, Blue, Alpha } ;
```

Example Recipe File
-------------------

Assuming you have [my farbfeld tools](https://github.com/sirjofri/ff-tools/)
installed.

```
# the size (this is a comment btw)
SIZE=256

result: dep color
	dep color | ff-mul

dep: glow sine
	glow sine | ff-mul

# it is also possible to make calculations inside []
glow:
	ff-glow([SIZE*2/2])

sine:
	ff-singen(SIZE SIZE 5)

color:
	ff-color(SIZE SIZE 1.0 0.8 0.2 1.0)
```
