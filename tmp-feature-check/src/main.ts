
import { Plugin, Notice } from "obsidian";
import { headingEditorExtension } from "./features/heading-editor";

export default class FeatureCheck extends Plugin {
  async onload(): Promise<void> {
    new Notice("Feature Check er aktiveret");
    this.registerEditorExtension(headingEditorExtension);
  }

  async onunload(): Promise<void> {
    new Notice("Feature Check er deaktiveret");
  }
}
