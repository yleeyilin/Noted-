"use strict";
/*
 * Copyright (c) "Neo4j"
 * Neo4j Sweden AB [http://neo4j.com]
 *
 * This file is part of Neo4j.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
Object.defineProperty(exports, "__esModule", { value: true });
exports.RawCypher = void 0;
const convert_to_cypher_params_1 = require("../utils/convert-to-cypher-params");
const Clause_1 = require("./Clause");
/** For compatibility reasons, allows for a raw string to be used as a clause
 * @group Other
 */
class RawCypher extends Clause_1.Clause {
    constructor(callback) {
        super();
        if (typeof callback === "string") {
            this.callback = this.stringToCallback(callback);
        }
        else
            this.callback = callback;
    }
    getCypher(env) {
        const cbResult = this.callback(env);
        if (!cbResult)
            return "";
        let query;
        let params = {};
        if (typeof cbResult === "string")
            query = cbResult;
        else {
            [query, params] = cbResult;
        }
        const cypherParams = (0, convert_to_cypher_params_1.convertToCypherParams)(params);
        env.addExtraParams(cypherParams);
        return query;
    }
    stringToCallback(str) {
        return () => str;
    }
}
exports.RawCypher = RawCypher;
//# sourceMappingURL=RawCypher.js.map