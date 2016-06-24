ENTRY(_start)
OUTPUT_FORMAT(binary)
INPUT(boot.o core.o set_mem.o)
OUTPUT(boot)
SECTIONS
{
  . = 0x7C00;
  .text : {*(.text)}
  . = 0x7DFE;
  .data : {*(.data)}
  .bss : {*(.bss)}
}
