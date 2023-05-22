import type { ProjectionColumn } from "../sub-clauses/Projection";
import { Return } from "../Return";
import { ClauseMixin } from "./ClauseMixin";
export declare abstract class WithReturn extends ClauseMixin {
    protected returnStatement: Return | undefined;
    return(...columns: Array<"*" | ProjectionColumn>): Return;
}
//# sourceMappingURL=WithReturn.d.ts.map