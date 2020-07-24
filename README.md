# Ethernet subsystem IP core test project

This is a project for testing the Ethernet subsystem IP core. 

Every directory contains
initial `README.md` with a short description of its designated contents. Below
you can find a general description of the files in the main directory.

## Pin mapping

| Design port            | Device pin | Board       | Board designation | Description                                           |
| -----------            | ---------- | -----       | ----------------- | -----------                                           |
| `sfp_rxp`              | AJ8        | Base board  | P1                | SFP module                                            |
| `sfp_rxn`              | AJ7        | Base board  | P1                | SFP module                                            |
| `sfp_txp`              | AK6        | Base board  | P1                | SFP module                                            |
| `sfp_txn`              | AK5        | Base board  | P1                | SFP module                                            |
| `mgt_clk_p`            | AF10       | Mini module | U22               | CDC clock synthesizer                                 |
| `mgt_clk_n`            | AF9        | Mini module | U22               | CDC clock synthesizer                                 |
| `sys_rst`              | AA30       | Base board  | SW8               | Reset push button (active high)                       |
| `mtrlb_pktchk_error`   | AH13       | Base board  | LED1              | Packet checker error (active high)                    |
| `mtrlb_activity_flash` | AD14       | Base board  | LED4              | Activity flash                                        |
| `start_config`         | AA29       | Base board  | SW10              | Update configuration, when pushed, config is updated. |
| `control_ready`        | AD16       | Base board  | LED2              |                                                       |
| `control_valid`        | Y28        | Base board  | SW9               |                                                       |
| `control_data [3]`     | AG12       | Base board  | SW6 (1)           | 4'h9 - demo mode, loopback on AXI                     |
| `control_data [2]`     | AH12       | Base board  | SW6 (2)           | 4'h5 - loopback at PHY                                |
| `control_data [1]`     | AF15       | Base board  | SW6 (3)           | 4'h4 - reset pkt error                                |
| `control_data [0]`     | AG15       | Base board  | SW6 (4)           | 4'h1 - 1Gbps                                          |
| `clk_in_p`             | F15        | Mini module | Y4                | 200 MHz LVDS oscillator                               |
| `clk_in_n`             | F14        | Mini module | Y4                | 200 MHz LVDS oscillator                               |

## `genflisth.sh` script

This generates a `*.txt` file for the `ctags` program. The program generates
a `tags` file, which can be used by the editor of choice to navigate through
the structure of the project. Command needed to generates those files properly
is presented below. 

*Important note*: it must be executed from this point in the directory 
structure!

```
./genflist.sh && ctags -R --languages=verilog --extras=+q --fields=+i -n -L tagfilelist.txt
```

The command generates the file list and executes `ctags`.
