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
class MMX {};

export class SmartPointers {
public:
	//represents unique ownership (its destructor destroys its object)
	void uniquePtr() {
		std::unique_ptr<MMX> sp{ new MMX };
		std::unique_ptr<MMX> sp3 = std::make_unique<MMX>();

		std::unique_ptr<MMX> sp2 = std::move(sp);
	}

	//represents shared ownership (the last shared pointer¡¯s destructor destroys the object)
	void sharedPtr() {
		std::shared_ptr<MMX> sp = std::make_shared<MMX>();
		std::shared_ptr<MMX> sp2 = sp;

		sp.reset();
		sp2.reset();
	}

	//A pointer to an object owned by a shared_ptr
	void weakPtr() {
		std::shared_ptr<MMX> sharedPtr = std::make_shared<MMX>();

		// Creating a weak pointer from the shared pointer
		std::weak_ptr<MMX> weakPtr = sharedPtr;

		// Using the weak pointer to access the object
		if (auto ptr = weakPtr.lock()) {
		}
		else {
			std::cout << "Weak pointer is expired." << std::endl;
		}

		// Resetting the shared pointer
		sharedPtr.reset();

		// Using the weak pointer again after resetting the shared pointer
		if (auto ptr = weakPtr.lock()) {
		}
		else {
			std::cout << "Weak pointer is expired." << std::endl;
		}
	}
};

//3.reference cycles problem
//no problem
class BB;

class AA {
public:
	BB* bb;
	~AA() { std::cout << "destruct AA" << std::endl; }
};

class BB {
public:
	AA* aa;
	~BB() { std::cout << "destruct BB" << std::endl; }
};

export void abc() {
	AA* pa = new AA();
	BB* pb = new BB();

	delete pa;
	delete pb;
	//pa, pa destruct
}

//ARC problem
class MMB;

export class MMA {
public:
	std::shared_ptr<MMB> b;
	~MMA() { std::cout << "destruct A" << std::endl; }
};

export class MMB {
public:
	std::shared_ptr<MMA> a;
	~MMB() { std::cout << "destruct B" << std::endl; }

};

export void rc() {
	std::shared_ptr<MMA> ca = std::make_shared<MMA>();
	std::shared_ptr<MMB> cb = std::make_shared<MMB>();
	ca->b = cb;
	cb->a = ca;

	ca.reset();
	cb.reset();
	//ca and cb never destruc
}

//4.weak reference
//Apartment has longer life than Person(tenant)
class Apartment;

export class Person {
public:
	std::shared_ptr<Apartment> apartment;
	~Person() { std::cout << "destruct Person" << std::endl; }
};

export class Apartment {
public:
	std::weak_ptr<Person> Person;
	~Apartment() { std::cout << "destruct Apartment" << std::endl; }
};

export void weakReference() {
	std::shared_ptr<Person> ca = std::make_shared<Person>();
	std::shared_ptr<Apartment> cb = std::make_shared<Apartment>();

	ca->apartment = cb;
	cb->Person = ca;

	ca.reset();
	//Person destruct

	cb.reset();
	//Apartment destruct
}

