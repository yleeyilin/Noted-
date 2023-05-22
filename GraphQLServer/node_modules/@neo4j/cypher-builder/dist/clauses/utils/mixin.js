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
exports.mixin = void 0;
function mixin(...mixins) {
    return (constructor) => {
        return applyMixins(constructor, mixins);
    };
}
exports.mixin = mixin;
// Based on https://www.typescriptlang.org/docs/handbook/mixins.html
/** Applies mixins into a class */
function applyMixins(baseClass, mixins) {
    mixins.forEach((baseCtor) => {
        Object.getOwnPropertyNames(baseCtor.prototype).forEach((name) => {
            if (name !== "constructor") {
                // Base class constructor takes precedence over mixins
                Object.defineProperty(baseClass.prototype, name, Object.getOwnPropertyDescriptor(baseCtor.prototype, name) || Object.create(null));
            }
        });
    });
    return baseClass;
}
//# sourceMappingURL=mixin.js.map