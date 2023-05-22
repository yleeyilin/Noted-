import type { Context } from "../types";
export default class ContextParser {
    static parseTag(value: string, tagName: "context" | "jwt"): string | undefined;
    static getProperty(path: string, context: Context): string | undefined;
}
//# sourceMappingURL=context-parser.d.ts.map