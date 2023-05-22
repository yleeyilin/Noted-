import { WithWhere } from "../../clauses/mixins/WithWhere";
import { CypherASTNode } from "../../CypherASTNode";
import type { CypherEnvironment } from "../../Environment";
import type { Expr } from "../../types";
import type { Variable } from "../../references/Variable";
export interface ListComprehension extends WithWhere {
}
/** Represents a List comprehension
 * @see [Cypher Documentation](https://neo4j.com/docs/cypher-manual/current/syntax/lists/#cypher-list-comprehension)
 * @group Expressions
 */
export declare class ListComprehension extends CypherASTNode {
    private variable;
    private listExpr;
    private mapExpr;
    constructor(variable: Variable, listExpr?: Expr);
    in(listExpr: Expr): this;
    map(mapExpr: Expr): this;
    getCypher(env: CypherEnvironment): string;
}
//# sourceMappingURL=ListComprehension.d.ts.map