#include <stdio.h>
#include <stdlib.h>

#define FRAMES 1024
#define BINS 1024

static float input_signal[FRAMES][BINS] __attribute__((aligned(32)));
static float ir_kernel[BINS][BINS] __attribute__((aligned(32)));
static float output_signal[FRAMES][BINS] __attribute__((aligned(32)));


// _______


void __attribute__((noinline)) generate_audio_buffers() {
    for (int f = 0; f < FRAMES; f++) {
        for (int b = 0; b < BINS; b++) {
            input_signal[f][b] = (float)((f + b * 3) % 128) * 0.005f;
            ir_kernel[f][b] = (float)((f * 7 + b) % 64) * 0.002f;
            output_signal[f][b] = 0.0f;
        }
    }
}


// _______


void __attribute__((noinline)) apply_ir_naive() {
    for (int f = 0; f < FRAMES; f++) {
        for (int b = 0; b < BINS; b++) {
            float acc = 0.0f;
            for (int tap = 0; tap < BINS; tap++) {
                acc += input_signal[f][tap] * ir_kernel[tap][b];
            }
            output_signal[f][b] = acc;
        }
    }
}


// _______


void __attribute__((noinline)) apply_ir_optimized() {
    for (int f = 0; f < FRAMES; f++) {
        for (int tap = 0; tap < BINS; tap++) {
            float sample = input_signal[f][tap];
            for (int b = 0; b < BINS; b++) {
                output_signal[f][b] += sample * ir_kernel[tap][b];
            }
        }
    }
}


// _______


float __attribute__((noinline)) compute_audio_energy() {
    float total = 0.0f;
    for (int f = 0; f < FRAMES; f++) {
        for (int b = 0; b < BINS; b++) {
            total += output_signal[f][b];
        }
    }
    return total;
}


// _______


int main() {
    generate_audio_buffers();

#ifdef OPTIMIZED
    apply_ir_optimized();
#else
    apply_ir_naive();
#endif

    float level = compute_audio_energy();
    printf("Audio Output Checksum: %.2f\n", level);
    return 0;
}
