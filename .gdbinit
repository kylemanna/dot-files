#set demangle-style none
set history save
set history filename ~/.gdb_history
set print pretty on

#
# Embedded Utilities
#
define reconnect
    target remote :3333
end

# Command OpenOCD to halt, build the source, load it, then continue
define reload
    #mon reset halt
    mon halt
    make
    load
    #mon reset init
    mon reset
    continue
end

define reset
    mon reset
end

# Recover an annoying Kinetis board
define recover
    mon srst_config srst_only
    mon kinetis mdm mass_erase
    mon reset init
end

#
# Embeded Linux Utilities
#
# gdb implementation of Linux lsmod to aid in debugging dyanmically 
# loaded modules and determinate the symbol base address
define lsmod
    set $current = modules.next
    set $offset =  ((int)&((struct module *)0).list) 
    printf "Module\tAddress\n"
 
    while($current.next != modules.next)
            printf "%s\t%p\n",  \
                    ((struct module *) (((void *) ($current)) - $offset ) )->name ,\
                    ((struct module *) (((void *) ($current)) - $offset ) )->module_core
            set $current = $current.next 
    end
end

define kl27_dump
    printf "SIM\n"
    printf "SIM_SOPT1:\t0x%x\n", 0x40047000
    printf "SIM_SOPT1CFG:\t0x%x\n", 0x40047004
    printf "SIM_SOPT2:\t0x%x\n", 0x40048004
    printf "SIM_SOPT4:\t0x%x\n", 0x4004800c
    printf "SIM_SOPT5:\t0x%x\n", 0x40048010
    printf "SIM_SOPT7:\t0x%x\n", 0x40048008
    printf "SIM_SDID:\t0x%x\n", 0x40048024
    printf "SIM_SCGC4:\t0x%x\n", 0x40048034
    printf "SIM_SCGC5:\t0x%x\n", 0x40048038
    printf "SIM_SCGC6:\t0x%x\n", 0x4004803c
    printf "SIM_SCGC7:\t0x%x\n", 0x40048040
    printf "SIM_CLKDIV1:\t0x%x\n", 0x40048044
    printf "SIM_FCFG1:\t0x%x\n", 0x4004804c
    printf "SIM_FCFG2:\t0x%x\n", 0x40048050
    printf "SIM_COPC:\t0x%x\n", 0x40048100
    printf "\n\n"

    printf "SMC\n"
    printf "SMC_PMPROT:\t0x%02x\n", *((uint8_t *)0x4007E000)
    printf "SMC_PMCTRL:\t0x%02x\n", *((uint8_t *)0x4007E001)
    printf "SMC_STOPCTRL:\t0x%02x\n", *((uint8_t *)0x4007E002)
    printf "SMC_PMSTAT:\t0x%02x\n", *((uint8_t *)0x4007E003)
    printf "\n\n"

    printf "PMC\n"
    printf "PMC_LVDSC1:\t0x%02x\n", *((uint8_t *)0x4007D000)
    printf "PMC_LVDSC2:\t0x%02x\n", *((uint8_t *)0x4007D001)
    printf "PMC_REGSC:\t0x%02x\n", *((uint8_t *)0x4007D002)
    printf "\n\n"

    printf "LLWU\n"
    printf "LLWU_PE1:\t0x%02x\n", *((uint8_t *)0x4007c000)
    printf "LLWU_PE2:\t0x%02x\n", *((uint8_t *)0x4007c001)
    printf "LLWU_PE3:\t0x%02x\n", *((uint8_t *)0x4007c002)
    printf "LLWU_PE4:\t0x%02x\n", *((uint8_t *)0x4007c003)
    printf "LLWU_ME:\t0x%02x\n", *((uint8_t *)0x4007c004)
    printf "LLWU_F1:\t0x%02x\n", *((uint8_t *)0x4007c005)
    printf "LLWU_F2:\t0x%02x\n", *((uint8_t *)0x4007c006)
    printf "LLWU_F3:\t0x%02x\n", *((uint8_t *)0x4007c007)
    printf "LLWU_FILT1:\t0x%02x\n", *((uint8_t *)0x4007c008)
    printf "LLWU_FILT2:\t0x%02x\n", *((uint8_t *)0x4007c009)
    printf "\n\n"

    printf "RCM\n"
    printf "RCM_SRS0:\t0x%02x\n", *((uint8_t *)0x4007F000)
    printf "RCM_SRS1:\t0x%02x\n", *((uint8_t *)0x4007F001)
    printf "RCM_RPFC:\t0x%02x\n", *((uint8_t *)0x4007F004)
    printf "RCM_RPFW:\t0x%02x\n", *((uint8_t *)0x4007F005)
    printf "RCM_FM:  \t0x%02x\n", *((uint8_t *)0x4007F006)
    printf "RCM_MR:  \t0x%02x\n", *((uint8_t *)0x4007F007)
    printf "RCM_SSRS0:\t0x%02x\n", *((uint8_t *)0x4007F008)
    printf "RCM_SSRS1:\t0x%02x\n", *((uint8_t *)0x4007F009)
    printf "\n\n"

    printf "MCG\n"
    printf "MCG_C1:  \t0x%02x\n", *((uint8_t *)0x40064000)
    printf "MCG_C2:  \t0x%02x\n", *((uint8_t *)0x40064001)
    printf "MCG_S:   \t0x%02x\n", *((uint8_t *)0x40064006)
    printf "MCG_SC:  \t0x%02x\n", *((uint8_t *)0x40064008)
    printf "MCG_MC:  \t0x%02x\n", *((uint8_t *)0x40064018)
    printf "\n\n"

    printf "OSC\n"
    printf "OSC0_CR:\t0x%02x\n", *((uint8_t *)0x40065000)
    printf "\n\n"

    printf "I2S\n"
    printf "I2S_TCSR:\t0x%08x\n", *(0x4002F000)
    printf "I2S_TCR2:\t0x%08x\n", *(0x4002F008)
    printf "I2S_TCR3:\t0x%08x\n", *(0x4002F00c)
    printf "I2S_TCR4:\t0x%08x\n", *(0x4002F010)
    printf "I2S_TCR5:\t0x%08x\n", *(0x4002F014)
    printf "I2S_TMR:\t0x%08x\n", *(0x4002F060)

    printf "I2S_RCSR:\t0x%08x\n", *(0x4002F080)
    printf "I2S_RCR2:\t0x%08x\n", *(0x4002F088)
    printf "I2S_RCR3:\t0x%08x\n", *(0x4002F08c)
    printf "I2S_RCR4:\t0x%08x\n", *(0x4002F090)
    printf "I2S_RCR5:\t0x%08x\n", *(0x4002F094)
    printf "I2S_RMR:\t0x%08x\n", *(0x4002F0E0)

    printf "I2S_MCR:\t0x%08x\n", *(0x4002F100)
    printf "\n\n"

    printf "DMA\n"
    printf "DMA_SAR0:\t0x%08x\n", *(0x40008100)
    printf "DMA_DAR0:\t0x%08x\n", *(0x40008104)
    printf "DMA_DSR_BCR0:\t0x%08x\n", *(0x40008108)
    printf "DMA_DCR0:\t0x%08x\n", *(0x4000810c)
    printf "\n"
    printf "DMA_SAR1:\t0x%08x\n", *(0x40008110)
    printf "DMA_DAR1:\t0x%08x\n", *(0x40008114)
    printf "DMA_DSR_BCR1:\t0x%08x\n", *(0x40008118)
    printf "DMA_DCR1:\t0x%08x\n", *(0x4000811c)
    printf "\n"
    printf "DMA_SAR2:\t0x%08x\n", *(0x40008120)
    printf "DMA_DAR2:\t0x%08x\n", *(0x40008124)
    printf "DMA_DSR_BCR2:\t0x%08x\n", *(0x40008128)
    printf "DMA_DCR2:\t0x%08x\n", *(0x4000812c)
    printf "\n"
    printf "DMA_SAR3:\t0x%08x\n", *(0x40008130)
    printf "DMA_DAR3:\t0x%08x\n", *(0x40008134)
    printf "DMA_DSR_BCR3:\t0x%08x\n", *(0x40008138)
    printf "DMA_DCR3:\t0x%08x\n", *(0x4000813c)
end
