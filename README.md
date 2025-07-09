# easygame

```bash
#!/bin/nu

cd schemas/obds-rki/dev

xsltproc ../xsd_analyse.xsl oBDS_v3.0.4_RKI.xsd | save -f oBDS_v3.0.4_RKI.txt

diff -u oBDS_v3.0.0.8a_RKI.txt oBDS_v3.0.4_RKI.txt | save -f 3008a_to_304.diff
```

by [smeisegeier](https://github.com/smeisegeier)
