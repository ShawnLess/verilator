#include <stdint.h>
#include "verilated.h"

#if VM_TRACE
#include <verilated_vcd_c.h>
#endif

#if VM_TRACE
#define STRINGIZE(x) #x
#define STRINGIZE_VALUE_OF(x) STRINGIZE(x)
#endif

using namespace std;

int main(int argc, char **argv, char **env) {

  Verilated::commandArgs(argc, argv);
  VNAME *top = new VNAME;

  unsigned long int main_time = 0;
  unsigned long int cycles = 0;

#if VM_TRACE
  Verilated::traceEverOn(true);
  VL_PRINTF("Enabling waves...\n");
  VerilatedVcdC* tfp = new VerilatedVcdC;
  top->trace (tfp, 99);
  tfp->open(STRINGIZE_VALUE_OF(VCD_FILE));
#endif

  top->clk_i = 0;
  top->rst_i = 1; // assert reset on start

  while (!Verilated::gotFinish() && cycles < TIMEOUT_CYCLES) {

#if VM_TRACE
    if( tfp ) tfp->dump(main_time);
#endif

    if (cycles > 4) { // de-assert reset after 4 cycles
      top->rst_i = 0;
    }

    if ((main_time % 10) == 0) {
      top->clk_i = 1;
      cycles++;
    }

    if ((main_time % 10) == 6) {
      top->clk_i = 0;
    }

    top->eval();
    main_time++;

  }

#if VM_TRACE
  if( tfp ) tfp->close();
#endif

  delete top;

  exit(0);

}
