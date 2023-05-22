import type Cypher from "@neo4j/cypher-builder";
/** Compiles the cypher of an element, if the resulting cypher is not empty adds a prefix */
export declare function compileCypherIfExists(element: any, env: Cypher.Environment, { prefix, suffix }?: {
    prefix?: string;
    suffix?: string;
}): string;
//# sourceMappingURL=compile-cypher-if-exists.d.ts.map