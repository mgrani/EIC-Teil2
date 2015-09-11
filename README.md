# EIC-Teil2

Folien für EIC (Teil 2) an der Universität Passau

## Struktur

Die VO ist aufgeteilt in Teile (Parts), welche wiederum aus units bestehen. Jeder Part ergibt ein eigenes PDF File. Jeder part befindet sich in einem Unterverzeichnis und enthält folgende Elemente

- `code` enthält einzubindende Code Snippets
- `figures` enthält Abbildungen
- `material` enthält Hintergrundmaterial
- `final-out` entählt die letzte Version
- `slides-de` enthält die tex sourcen

Das Verzeichnis 'EIC-medien-generic' entählt die jeweiligen Latex Style und Class Dateien

## Kompilieren

Voraussetzung: installiertes PDFLatex Paket

Kommando:
	 
	 cd <Path to Directory>/PART-NAME/slides-de
     TEXINPUTS="../../EIC-medien-generic/:" pdflatex part-de-mt-vektorgrafik-und-svg.tex

## Inhalte

- Kodierung von Medien (Binäre Codes, Informationstheorie, Kompression)
- Medium Bild (Farbwahrnehmung und -modelle, Digitalisierung, JPEG)
- Vektorrafiken und SVG



