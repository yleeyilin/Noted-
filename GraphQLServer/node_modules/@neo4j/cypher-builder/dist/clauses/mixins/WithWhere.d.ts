import { ClauseMixin } from "./ClauseMixin";
import { Where } from "../sub-clauses/Where";
import { PropertyRef } from "../../references/PropertyRef";
import type { Predicate } from "../../types";
import { Reference } from "../../references/Reference";
import type { RelationshipRef } from "../../references/RelationshipRef";
import type { NodeRef } from "../../references/NodeRef";
import type { Variable } from "../../references/Variable";
import type { Literal } from "../../references/Literal";
export type VariableLike = Reference | Literal | PropertyRef;
type VariableWithProperties = Variable | NodeRef | RelationshipRef | PropertyRef;
export declare abstract class WithWhere extends ClauseMixin {
    protected whereSubClause: Where | undefined;
    where(input: Predicate): this;
    where(target: VariableWithProperties, params: Record<string, VariableLike>): this;
    and(input: Predicate): this;
    and(target: VariableWithProperties, params: Record<string, VariableLike>): this;
    private updateOrCreateWhereClause;
    private createWhereInput;
    /** Transforms a simple input into an operation sub tree */
    private variableAndObjectToOperation;
}
export {};
//# sourceMappingURL=WithWhere.d.ts.map