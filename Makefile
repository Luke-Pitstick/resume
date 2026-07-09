TEX = Luke_Pitstick_Resume.tex
PDF = Luke_Pitstick_Resume.pdf
BUILD = build

watch:
	mkdir -p $(BUILD)
	latexmk -pdf -pvc -outdir=$(BUILD) -interaction=nonstopmode -halt-on-error $(TEX)

build:
	mkdir -p $(BUILD)
	latexmk -pdf -outdir=$(BUILD) -interaction=nonstopmode -halt-on-error $(TEX)

open:
	open -a Skim $(BUILD)/$(PDF)

clean:
	latexmk -C -outdir=$(BUILD)
	rm -rf $(BUILD)
