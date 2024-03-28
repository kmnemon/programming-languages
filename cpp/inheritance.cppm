export module classes : inheritance;

import std;

//1. class B inherit from class A, init order
class A {
public:
	A(int a) : a{ a } { std::cout<<"A"<<std::endl; }
	~A() {}

private:
	int a;
	
};

class B {
public:
	B(int b) : b{ b } { std::cout << "B" << std::endl; }
	~B() {}

private:
	int b;

};

export class S : public A, B {
public:
	S(int s, int a, int b) :  A(a), B(b), s{ s } { std::cout << "S" << std::endl; } //A B S
private:
	int s;

};

//2.access superclass
class Base1 {
public:
	Base1(int b1) : b1{ b1 } {}

	virtual void baseFunc() {}

private:
	int b1;
};

class Derived1 : public Base1 {
public:
	Derived1(int b1, int d1) : Base1(b1), d1{ d1 } {}

	//a.access superclass method
	void baseFunc() override {
		Base1::baseFunc();
	}

private:
	int d1;
};