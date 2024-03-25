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

	//A pointer to an object owned by a shared_ptr
	void weakPtr() {
		std::shared_ptr<X> sharedPtr = std::make_shared<X>();

		// Creating a weak pointer from the shared pointer
		std::weak_ptr<X> weakPtr = sharedPtr;

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
class B;

export class A {
public:
	std::shared_ptr<B> b;
	~A() { std::cout << "destruct A" << std::endl; }
};

export class B {
public:
	std::shared_ptr<A> a;
	~B() { std::cout << "destruct B" << std::endl; }

};

export void rc() {
	std::shared_ptr<A> ca = std::make_shared<A>();
	std::shared_ptr<B> cb = std::make_shared<B>();
	ca->b = cb;
	cb->a = ca;

	ca.reset();
	cb.reset();
	//ca and cb never destruct
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