import type { Driver } from "neo4j-driver";
import type Node from "../Node";
import type { DriverConfig } from "../..";
import type { Neo4jDatabaseInfo } from "../Neo4jDatabaseInfo";
export interface AssertIndexesAndConstraintsOptions {
    create?: boolean;
}
declare function assertIndexesAndConstraints({ driver, driverConfig, nodes, options, dbInfo, }: {
    driver: Driver;
    driverConfig?: DriverConfig;
    nodes: Node[];
    options?: AssertIndexesAndConstraintsOptions;
    dbInfo: Neo4jDatabaseInfo;
}): Promise<void>;
export default assertIndexesAndConstraints;
//# sourceMappingURL=asserts-indexes-and-constraints.d.ts.map