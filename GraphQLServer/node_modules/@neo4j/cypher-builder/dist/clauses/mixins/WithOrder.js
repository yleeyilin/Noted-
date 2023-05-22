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
exports.WithOrder = void 0;
const OrderBy_1 = require("../sub-clauses/OrderBy");
const ClauseMixin_1 = require("./ClauseMixin");
const DEFAULT_ORDER = "ASC";
class WithOrder extends ClauseMixin_1.ClauseMixin {
    orderBy(...exprs) {
        const normalizedExprs = exprs.map((rawExpr) => {
            if (Array.isArray(rawExpr)) {
                return [rawExpr[0], rawExpr[1] || DEFAULT_ORDER];
            }
            return [rawExpr, DEFAULT_ORDER];
        });
        const orderByStatement = this.getOrCreateOrderBy();
        orderByStatement.addOrderElements(normalizedExprs);
        return this;
    }
    skip(value) {
        const orderByStatement = this.getOrCreateOrderBy();
        orderByStatement.skip(value);
        return this;
    }
    limit(value) {
        const orderByStatement = this.getOrCreateOrderBy();
        orderByStatement.limit(value);
        return this;
    }
    getOrCreateOrderBy() {
        if (!this.orderByStatement)
            this.orderByStatement = new OrderBy_1.OrderBy();
        return this.orderByStatement;
    }
}
exports.WithOrder = WithOrder;
//# sourceMappingURL=WithOrder.js.map