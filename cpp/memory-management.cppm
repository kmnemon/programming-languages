export module resource : memory;

import std;

//1. manual management
export class Manual {
public:
	Manual(int s) :elem{ new double[s] }, sz{ s } {}

	~Manual() {
		delete[] elem;
	}

private:
	double* elem;
	int sz;
};

//2. smart pointers
class X {};

export class SmartPointers {
public:
	//represents unique ownership (its destructor destroys its object)
	void uniquePtr() {
		std::unique_ptr<X> sp{ new X };
		std::unique_ptr<X> sp3 = std::make_unique<X>();

		std::unique_ptr<X> sp2 = std::move(sp);
	}

	//represents shared ownership (the last shared pointer¡¯s destructor destroys the object)
	void sharedPtr() {
		std::shared_ptr<X> sp = std::make_shared<X>();
		std::shared_ptr<X> sp2 = sp;

		sp.reset();
		sp2.reset();
	}
};