import type { ObjectFields } from "../../../schema/get-obj-field-meta";
import type Node from "../../../classes/Node";
import type { SubscriptionsEvent } from "../../../types";
import type { SubscriptionContext } from "./types";
export declare function subscriptionResolve(payload: [SubscriptionsEvent]): SubscriptionsEvent;
type SubscriptionArgs = {
    where?: Record<string, any>;
};
export declare function generateSubscribeMethod({ node, type, nodes, relationshipFields, }: {
    node: Node;
    type: "create" | "update" | "delete" | "create_relationship" | "delete_relationship";
    nodes?: Node[];
    relationshipFields?: Map<string, ObjectFields>;
}): (_root: any, args: SubscriptionArgs, context: SubscriptionContext) => AsyncIterator<[SubscriptionsEvent]>;
export {};
//# sourceMappingURL=subscribe.d.ts.map