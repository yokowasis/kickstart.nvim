//@ts-check

/** @type {{a:string, b:string}} */
const aa = /** @type {*} */ (window).aa;

aa.b = "aaqqq"; // Error: Type '1' is not assignable to type 'string'.
