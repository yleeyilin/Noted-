import type { Context } from "../types";
export interface NodeDirectiveConstructor {
    label?: string;
    additionalLabels?: string[];
    labels?: string[];
    plural?: string;
}
export declare class NodeDirective {
    readonly label: string | undefined;
    readonly additionalLabels: string[];
    readonly plural: string | undefined;
    readonly labels: string[];
    constructor(input: NodeDirectiveConstructor);
    getLabelsString(typeName: string, context: Context): string;
    getLabels(typeName: string, context: Context): string[];
    private mapLabelsWithContext;
    private escapeLabel;
}
//# sourceMappingURL=NodeDirective.d.ts.map