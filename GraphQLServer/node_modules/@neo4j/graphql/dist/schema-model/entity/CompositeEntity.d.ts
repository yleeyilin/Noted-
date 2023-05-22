import type { ConcreteEntity } from "./ConcreteEntity";
import type { Entity } from "./Entity";
/** Entity for abstract GraphQL types, Interface and Union */
export declare class CompositeEntity implements Entity {
    readonly name: string;
    concreteEntities: ConcreteEntity[];
    constructor({ name, concreteEntities }: {
        name: string;
        concreteEntities: ConcreteEntity[];
    });
}
//# sourceMappingURL=CompositeEntity.d.ts.map