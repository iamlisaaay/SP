#!/bin/bash
PROG=$1
NAME=$2

IDLE_WATTS=6.50
CPU_TDP_WATTS=15.0


# _______


STATS=$(perf stat -e task-clock,cycles,instructions,cache-misses -x, $PROG 2>&1)

TASK_NS=$(echo "$STATS" | grep "task-clock" | cut -d',' -f1 | tr ',' '.')
CYCLES=$(echo "$STATS" | grep "cycles" | cut -d',' -f1)
INSTR=$(echo "$STATS" | grep "instructions" | cut -d',' -f1)
MISSES=$(echo "$STATS" | grep "cache-misses" | cut -d',' -f1)


# _______


TIME_SEC=$(awk "BEGIN {val = $TASK_NS; if (val > 100000) val = val / 1000000000.0; else val = val / 1000.0; printf \"%.4f\", val}")
PROG_JOULES=$(awk "BEGIN {printf \"%.4f\", ($TIME_SEC * $CPU_TDP_WATTS) + ($MISSES * 0.000000015)}")
SYS_JOULES=$(awk "BEGIN {printf \"%.4f\", ($TIME_SEC * $IDLE_WATTS) + $PROG_JOULES}")

AVG_SYS_WATTS=$(awk "BEGIN {printf \"%.2f\", $SYS_JOULES / $TIME_SEC}")
AVG_PROG_WATTS=$(awk "BEGIN {printf \"%.2f\", $PROG_JOULES / $TIME_SEC}")


# _______


echo "===================================================="
echo " Вимірювання енерговитрат для: $NAME ($PROG)"
echo "===================================================="
echo "Час виконання (Active CPU Time) : $TIME_SEC сек"
echo "Виконано тактів (CPU Cycles)    : $CYCLES"
echo "Виконано інструкцій             : $INSTR"
echo "Промахи кешу (Cache Misses)     : $MISSES"
echo "----------------------------------------------------"
echo "[3.1] Енерговитрати СИСТЕМИ загалом : $SYS_JOULES Дж (Середня потужність: $AVG_SYS_WATTS Вт)"
echo "[3.2] Енерговитрати ЧИСТО ПРОГРАМИ  : $PROG_JOULES Дж (Середня потужність: $AVG_PROG_WATTS Вт)"
echo "===================================================="
