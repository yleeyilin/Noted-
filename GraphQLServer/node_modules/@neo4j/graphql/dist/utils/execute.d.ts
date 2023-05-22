import type { SessionMode, QueryResult } from "neo4j-driver";
import type { Context } from "../types";
export interface ExecuteResult {
    bookmark: string | null;
    result: QueryResult;
    statistics: Record<string, number>;
    records: Record<PropertyKey, any>[];
}
declare function execute({ cypher, params, defaultAccessMode, context, }: {
    cypher: string;
    params: any;
    defaultAccessMode: SessionMode;
    context: Context;
}): Promise<ExecuteResult>;
export default execute;
//# sourceMappingURL=execute.d.ts.map