contract D {
	uint public x;
	function setD(uint _x) public { x = _x; }
}

contract C {
	struct S {
		address d;
	}
	struct T {
		S s;
	}
	T t;
	constructor() {
		t.s.d = address(new D());
		assert(D(t.s.d).x() == 0); // should hold
	}
	function f() public view {
		assert(D(t.s.d).x() == 0); // should fail
	}
}
// ====
// SMTEngine: chc
// SMTExtCalls: trusted
// SMTTargets: assert
// ----
// Warning 6328: (266-291): CHC: Assertion violation happens here.\nCounterexample:\nt = {s: {d: 0x5039}}\n\nTransaction trace:\nC.constructor()\nState: t = {s: {d: 0x5039}}\nC.f()
