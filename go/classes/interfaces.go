package classes

// 1.require method
type SomeMethod interface {
	someMethod() int
}

type SomeMethodStruct int

func (i *SomeMethodStruct) someMethod() int {
	return 1
}

// 2. interface combination
type Reader interface {
	Read(p []byte) (n int, err error)
}

type Writer interface {
	Write(p []byte) (n int, err error)
}

type ReadWrite interface {
	Reader
	Writer
}

// 3.type assertions
func ta() {
	var s SomeMethod
	s = SomeMethodStruct{}
	sms := s.(SomeMethod)
	
}

//4.type switch
