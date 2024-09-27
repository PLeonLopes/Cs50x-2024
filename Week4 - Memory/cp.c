// COPYING AN IMAGE :O
# include <stdio.h>
# include <stdint.h>

typedef uint8_t BYTE;       // unsigned 8-bytes int called BYTE

int main (int argc, char *argv[]) {

    FILE *src = fopen(argv[1], "rb");       // RB -> READ BINARY DATA
    FILE *dst = fopen(argv[2], "wb");       // WB -> WRITE DATA BINARY

    BYTE b;

    while (fread(&b, sizeof(b), 1, src) != 0) {
        fwrite(&b, sizeof(b), 1, dst);
    }

    fclose(dst);
    fclose(src);
}
