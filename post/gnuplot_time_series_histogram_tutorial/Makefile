CHARTS=shellhist-barcode.svg shellhist-binned.svg shellhist-boxes.svg

charts: $(CHARTS)

%.svg: index.md
	./plot.pl

clean:
	rm -f $(CHARTS)

.PHONY: clean
