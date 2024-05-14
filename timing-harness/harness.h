#ifndef HARNESS_H
#define HARNESS_H

#include <stdint.h>
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define HARNESS_ITERS 16

// use this to create a shm fd for measurement
int create_shm_fd(char *path);

struct pmc_counters {
  uint64_t core_cyc;
  uint64_t l1_read_misses;
  uint64_t l1_write_misses;
  uint64_t icache_misses;
  uint64_t context_switches;
};

struct pmc_counters *measure(
    char *code_to_test,
    unsigned long code_size,
    unsigned int unroll_factor,
    int *l1_read_supported,
    int *l1_write_supported,
    int *icache_supported,
    int shm_fd);

uint8_t parse_hex_digit(char c);

uint8_t *hex2bin(char *hex);

uint8_t *imm_for_clflush(char *imm) {
  size_t len = strlen(imm);
  assert(len % 2 == 0);
  // flip the bytes
  char flipped_imm[len];
  size_t j;
  for (j = 0; j < len; j++) {
    flipped_imm[j] = imm[len - j - 1];
  }
  printf("flipped_imm: %s\n", flipped_imm);
  return hex2bin(flipped_imm);
}


#endif // HARNESS_H
