export module classes : object;

import std;

//1.friendship
export class ObjectA {
	int a;

public:
	ObjectA(int a) : a{ a } {}

	friend class ObjectF;	
};

export class ObjectF {
public:
	void f(ObjectA& a) { std::cout << a.a << std::endl; }
};


//2.default - If you are explicit about some defaults, other default definitions will not be generated.
export class Default {
public:
	Default(ObjectA a) {}
	Default(const Default&) = default;
	Default(Default&&) = default;
};

//3.Delete - to indicate that an operation is not to be generated
export class Delete {
public:
	Delete(const Delete&) = delete;
	Delete& operator= (const Delete&) = delete;
};

//4.explicit -  Explicit ex(7) could work, Explicit ex = 7 forbidden 
export class Explicit {
public:
	explicit Explicit(int a){}
};

//5.member initializer - The default value is used whenever a constructor doesn¡¯t provide a value
export class MemberInitializer {
	int a = 6;

public:
	MemberInitializer() {}
	MemberInitializer(int a) : a{ a } {}
};



