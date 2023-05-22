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
exports.WithUnwind = void 0;
const ClauseMixin_1 = require("./ClauseMixin");
const Unwind_1 = require("../Unwind");
class WithUnwind extends ClauseMixin_1.ClauseMixin {
    unwind(...columns) {
        if (this.unwindStatement) {
            this.unwindStatement.addColumns(...columns);
        }
        else {
            this.unwindStatement = new Unwind_1.Unwind(...columns);
            this.addChildren(this.unwindStatement);
        }
        return this.unwindStatement;
    }
}
exports.WithUnwind = WithUnwind;
//# sourceMappingURL=WithUnwind.js.map