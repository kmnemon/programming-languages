export module object : interfaces;

class Shape {
public:
	virtual int center() const = 0;
	virtual void move(int p) = 0;

	virtual ~Shape() {}
};

class SquareShape : public Shape {
	virtual int length() const = 0;
};

export class Circle : public SquareShape {
public:
	Circle(int rad) : r{ rad } {}

	int center() const override{ return 1; }
	void move(int p) override;
	int length() const override { return 1; }

private:
	int r;
};

void Circle::move(int p) {}



