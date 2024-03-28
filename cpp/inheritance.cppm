export module classes : inheritance;

import std;

//1. class B inherit from class A
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