#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>

uint32_t intRange(uint32_t min, uint32_t max);
uint32_t d2();
uint32_t d4();
uint32_t d6();
uint32_t d6Count(uint32_t count);
uint32_t d8();
uint32_t d10();
uint32_t d12();
uint32_t d20();
uint32_t d100();

typedef enum {
    miss,
    weak,
    strong,
} ChallengeRollResult;

ChallengeRollResult challengeRoll(int32_t modifier);

#ifdef __cplusplus
}
#endif

