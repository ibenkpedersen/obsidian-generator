import { EditorView } from "@codemirror/view";

export const headingEditorExtension = [
  EditorView.theme({
    ".cm-header-1, .cm-header-2, .cm-header-3, .cm-header-4, .cm-header-5, .cm-header-6": {
      fontWeight: "700",
      letterSpacing: "0.02em",
      borderRadius: "4px",
    },
  }),
  EditorView.updateListener.of((update) => {
    if (update.docChanged) {
      // Dette er et eksempel på en CodeMirror 6-extension.
      // Du kan udvide den med custom heading-regler senere.
    }
  }),
];
