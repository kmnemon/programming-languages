export module object : inheritance;

import std;

//1. class B inherit from class A, init order
class MMA {
	int a;

public:
	MMA(int a) : a{ a } { std::cout<<"A"<<std::endl; }
	~MMA() {}
};

class MMB {
	int b;

public:
	MMB(int b) : b{ b } { std::cout << "B" << std::endl; }
	~MMB() {}

};

export class S : public MMA, MMB {
	int s;

public:
	S(int s, int a, int b) :  MMA(a), MMB(b), s{ s } { std::cout << "S" << std::endl; } //A B S
};

//2.access superclass
class Base1 {
	int b1;

public:
	Base1(int b1) : b1{ b1 } {}

	virtual void baseFunc() {}

};

class Derived1 : public Base1 {
	int d1;

public:
	Derived1(int b1, int d1) : Base1(b1), d1{ d1 } {}

	//a.access superclass method
	void baseFunc() override {
		Base1::baseFunc();
	}
};