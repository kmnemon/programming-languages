export module classes : object;

import std;

//friendship
class A {
public:
	A(int a) : a{ a } {}

	friend class F;
private:
	int a;
};

export class F {
public:
	void f(A& a) { std::cout << a.a << std::endl; }
};
