#include "anne_dice.h"
#include <stdio.h>
#include <inttypes.h>

int main(int argc, char **argv) {
    uint32_t dice_two = d2();
    uint32_t dice_four = d4();
    uint32_t dice_six = d6();
    ChallengeRollResult challenge = challengeRoll(0);
    printf("d2: %d\n", dice_two);
    printf("d4: %d\n", dice_four);
    printf("d6: %d\n", dice_six);
    printf("challenge: %d\n", (int)challenge);
    return 0;
}

