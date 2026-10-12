# Projekt: Obsidian plugin-generator

## Om mig (brugeren)
- Jeg laver Obsidian-plugins som hobby. Jeg har brugt TypeScript, React Native og Expo, men er ikke erfaren programmør.
- Jeg er nyskiftet fra Windows til Ubuntu og er stadig usikker i terminalen.
- Jeg bruger VS Code.
- Forklar gerne kort, hvad kommandoer gør, før de køres, især dem med `sudo`. Jeg vil gerne lære undervejs.
- Kommuniker på dansk.

## Målet
Fjerne de dage, det tager at sætte et udviklingsmiljø op, så jeg hurtigt kan komme fra idé til et plugin, der kører i Obsidian.

## Plan: to adskilte dele

### Del 1: Ubuntu-opsætning (bash-script, køres én gang)
- Node.js via `fnm` eller `nvm` (ikke `apt`, da den version ofte er gammel)
- git og GitHub CLI (`gh`), plus `gh auth login` (det trin gør jeg selv i browseren)
- Tjek hvad der allerede er installeret, før noget installeres
- Scriptet skal kunne køres flere gange uden at gå i stykker

### Del 2: Plugin-generator (Node/TypeScript CLI, køres for hvert nyt plugin)
- Interaktive spørgsmål med `@clack/prompts`
- Spørger om: navn, id, beskrivelse, forfatter
- Lader mig vælge features (flere kan vælges):
  - Indstillingsside (settings tab)
  - Kommandoer i command palette
  - Ribbon-ikon
  - Modal/dialog
  - Editor-udvidelse (CodeMirror 6), fx til at ændre hvordan overskrifter opfører sig
  - Markdown post processor (læsevisning)
  - React-baserede views
- Valgfrit: opret GitHub-repo med `gh repo create`
- Valgfrit: GitHub Actions-workflow til automatiske releases
- Princip: en minimal grund-skabelon plus små feature-moduler, der sættes ind efter behov. Ikke den officielle sample-plugin med ting slettet.

### Udviklingsflow, som generatoren også sætter op
- En separat test-vault, så mine rigtige noter ikke røres
- Symlink fra projektet til test-vaultens `.obsidian/plugins/<plugin-id>/`
- Community-pluginet "Hot Reload" i test-vaulten
- `npm run dev` med esbuild i watch-mode

## Rækkefølge
1. Ubuntu-opsætningsscriptet
2. Minimal generator: kun navn/id + grund-skabelon + symlink til test-vault
3. Tilføj feature-moduler ét ad gangen, startende med editor-udvidelsen til overskrifter

## Arbejdsform
- Små trin. Få én ting til at virke, før den næste startes.
- Test i rigtig Obsidian undervejs.
