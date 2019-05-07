// +build !amd64

package xxh32

import (
	"encoding/binary"
)

func hashBlocks(input []byte, p, n int64, v1, v2, v3, v4 uint32) (int, uint32, uint32, uint32, uint32) {
	for ; p <= n; p += 16 {
		sub := input[p:][:16] //BCE hint for compiler
		v1 = rol13(v1+binary.LittleEndian.Uint32(sub[:])*prime32_2) * prime32_1
		v2 = rol13(v2+binary.LittleEndian.Uint32(sub[4:])*prime32_2) * prime32_1
		v3 = rol13(v3+binary.LittleEndian.Uint32(sub[8:])*prime32_2) * prime32_1
		v4 = rol13(v4+binary.LittleEndian.Uint32(sub[12:])*prime32_2) * prime32_1
	}
	return int(p), v1, v2, v3, v4
}
