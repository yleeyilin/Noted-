/// <reference types="node" />
import { EventEmitter } from "events";
import type { Neo4jGraphQLSubscriptionsPlugin, SubscriptionsEvent } from "../types";
/** Default subscriptions plugin for debug */
export declare class Neo4jGraphQLSubscriptionsSingleInstancePlugin implements Neo4jGraphQLSubscriptionsPlugin {
    events: EventEmitter;
    publish(eventMeta: SubscriptionsEvent): void | Promise<void>;
}
//# sourceMappingURL=Neo4jGraphQLSubscriptionsSingleInstancePlugin.d.ts.map