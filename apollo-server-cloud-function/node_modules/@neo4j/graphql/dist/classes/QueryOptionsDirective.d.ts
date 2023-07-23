import type { Integer } from "neo4j-driver";
type QueryOptionsDirectiveConstructor = {
    limit: {
        default?: Integer;
        max?: Integer;
    };
};
export declare class QueryOptionsDirective {
    private limit;
    constructor(args: QueryOptionsDirectiveConstructor);
    getLimit(optionsLimit?: Integer | number): Integer | undefined;
}
export {};
//# sourceMappingURL=QueryOptionsDirective.d.ts.map