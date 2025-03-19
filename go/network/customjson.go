package network

type foo struct{}

func (foo) MarshaJSON() ([]byte, error) {
	return []byte(`"foo`), nil
}
