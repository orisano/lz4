// +build amd64

package xxh32

func hashBlocks(input []byte, p, n int64, v1, v2, v3, v4 uint32) (int, uint32, uint32, uint32, uint32)

