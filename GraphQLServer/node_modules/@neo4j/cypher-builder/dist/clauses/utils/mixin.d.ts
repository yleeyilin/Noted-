import type { ClauseMixin } from "../mixins/ClauseMixin";
type AbstractConstructorType<T> = abstract new (...args: any[]) => T;
export declare function mixin(...mixins: AbstractConstructorType<ClauseMixin>[]): any;
export {};
//# sourceMappingURL=mixin.d.ts.map