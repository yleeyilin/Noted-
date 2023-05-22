import type { Context } from "../../../types";
import type { CallbackBucket } from "../../../classes/CallbackBucket";
import type { Visitor, ICreateAST, INestedCreateAST, IAST } from "../GraphQLInputAST/GraphQLInputAST";
import Cypher from "@neo4j/cypher-builder";
type UnwindCreateScopeDefinition = {
    unwindVar: Cypher.Variable;
    parentVar: Cypher.Variable;
    clause?: Cypher.Clause;
};
type GraphQLInputASTNodeRef = string;
type UnwindCreateEnvironment = Record<GraphQLInputASTNodeRef, UnwindCreateScopeDefinition>;
export declare class UnwindCreateVisitor implements Visitor {
    unwindVar: Cypher.Variable;
    callbackBucket: CallbackBucket;
    context: Context;
    rootNode: Cypher.Node | undefined;
    clause: Cypher.Clause | undefined;
    environment: UnwindCreateEnvironment;
    constructor(unwindVar: Cypher.Variable, callbackBucket: CallbackBucket, context: Context);
    visitChildren(currentASTNode: IAST, unwindVar: Cypher.Variable, parentVar: Cypher.Variable): (Cypher.Clause | undefined)[];
    visitCreate(create: ICreateAST): void;
    visitNestedCreate(nestedCreate: INestedCreateAST): void;
    private getAuthNodeClause;
    private getAuthFieldClause;
    build(): [Cypher.Node?, Cypher.Clause?];
}
export {};
//# sourceMappingURL=UnwindCreateVisitor.d.ts.map