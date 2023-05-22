import type { Driver } from "neo4j-driver";
import type { DriverConfig } from "../../types";
import type { Neo4jDatabaseInfo } from "../Neo4jDatabaseInfo";
declare function checkNeo4jCompat({ driver, driverConfig, dbInfo, }: {
    driver: Driver;
    driverConfig?: DriverConfig;
    dbInfo: Neo4jDatabaseInfo;
}): Promise<void>;
export default checkNeo4jCompat;
//# sourceMappingURL=verify-database.d.ts.map