# Obsidian plugin generator

Et lille CLI-værktøj til at skabe en minimal Obsidian-plugin skabelon med et simpelt spørgsmålsgui.

## Brug

```bash
npm install
npm run dev
```

## Hvad generatoren laver

- Validerer navn og plugin ID
- Opretter en ny plugin-mappe
- Genererer en minimal Obsidian plugin med TypeScript
- Opretter en symlink til en test-vault i `.obsidian/plugins/<plugin-id>/`

## Delmål

Denne første version er den minimale grundskabelon. Senere kan det udvides med flere featuremoduler.
