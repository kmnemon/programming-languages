package memorysyn

import (
	"image"
	"sync"
)

// 1.Lazy Initialization - sync.Once
var loadIconsOnce sync.Once
var icons map[string]image.Image

func loadIcons() {}

// Concurrency-safe.
func Icon(name string) image.Image {
	loadIconsOnce.Do(loadIcons)
	return icons[name]
}
