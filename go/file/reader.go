package file

import (
	"bufio"
	"io"
	"strings"
)

func countEmptyLines(reader io.Reader) (int, error) {
	scanner := bufio.NewScanner(reader)
	emptyLineCount := 0

	for scanner.Scan() {
		line := scanner.Text()

		if strings.TrimSpace(line) == "" {
			emptyLineCount++
		}
	}

	if err := scanner.Err(); err != nil {
		return 0, err
	}

	return emptyLineCount, nil
}
