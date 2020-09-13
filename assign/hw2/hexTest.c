/*
 * Tests for hexdump functions
 */

#include <stdlib.h>
#include <string.h>
#include "tctest.h"

/*
 * Prototypes for assembly functions defined in hexFuncs.S
 */
long addLongs(long a, long b); /* example assembly function */
void byteToHex(long val, char *s);
/* TODO: add prototypes for your assembly language functions */

/* TODO: add #defines for constants used by your assembly language functions */

/*
 * Test fixture data type
 */
typedef struct {
	/*
	 * TODO: add fields for data needed by test functions
	 */
} TestObjs;

/*
 * Test fixture setup/cleanup functions: these
 * are called automatically as part of executing each
 * test function.
 */
TestObjs *setup(void);
void cleanup(TestObjs *objs);

/* test functions */
void testAddLongs(TestObjs *objs); /* example test function */
void testByteToHex(TestObjs *objs);
/* TODO: add prototypes for your test functions */

int main(void) {
	TEST_INIT();

	TEST(testAddLongs);
	TEST(testByteToHex);
	/* TODO: use the TEST macro to execute each of your test functions */

	TEST_FINI();
}

TestObjs *setup(void) {
	TestObjs *objs = malloc(sizeof(TestObjs));
	/* TODO: initialize fields of test fixture as necessary */
	return objs;
}

void cleanup(TestObjs *objs) {
	free(objs);
}

/*
 * Example test function
 */
void testAddLongs(TestObjs *objs) {
	ASSERT(2L == addLongs(1L, 1L));
	ASSERT(11L == addLongs(9L, 2L));
	ASSERT(-3L == addLongs(-14L, 11L));
}

void testByteToHex(TestObjs *objs) {
	char buf[10];

	byteToHex(0x29, buf);
	ASSERT(0 == strcmp(buf, "29"));

	byteToHex(0xC, buf);
	ASSERT(0 == strcmp(buf, "0c"));
}
