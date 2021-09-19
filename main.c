//main.c

#include "Resource.h"

static volatile int* const PPU_BG1_SCROLL_X = 0x2810;
static volatile int* const PPU_BG1_SCROLL_Y = 0x2811;
static volatile int* const PPU_BG1_ATTR = 0x2812;
static volatile int* const PPU_BG1_CTRL = 0x2813;
static volatile int* const PPU_BG1_TILE_ADDR = 0x2814;

static volatile int* const PPU_BG2_CTRL = 0x2819;

static volatile int* const PPU_BG1_SEGMENT_ADDR = 0x2820;

static volatile int* const PPU_SPRITE_CTRL = 0x2842;
static volatile int* const PPU_COLOR = 0x2B00;

static volatile int* const SYSTEM_CTRL = 0x3d20;
static volatile int* const WATCHDOG_CLEAR = 0x3d24;

static int tilemap[2048];

#define make_color(r, g, b) ((r << 10) | (g << 5) | (b << 0))

int main()
{
	int i;
	const char* const message = "Hello V.Smilers!";
	
	*SYSTEM_CTRL = 0;
	*WATCHDOG_CLEAR = 0x55aa;

	*PPU_BG1_SCROLL_X = 0;
	*PPU_BG1_SCROLL_Y = 0;
	*PPU_BG1_ATTR = 0;
	*PPU_BG1_CTRL = 0x0a;
	*PPU_BG2_CTRL = 0;
	*PPU_SPRITE_CTRL = 0;
	
	for (i = 0; i < sizeof(tilemap); i++)
		tilemap[i] = 0x20;
	
	*PPU_BG1_TILE_ADDR = tilemap;
	*PPU_BG1_SEGMENT_ADDR = RES_FONT_BIN_SA >> 6;
	
	PPU_COLOR[0] = make_color(29, 26, 15);
	PPU_COLOR[1] = make_color(0, 8, 16);
		
	for (i = 0; message[i] != 0; i++) {
		tilemap[64*2 + 3 + i] = message[i];	
	}

	return 0;
}
