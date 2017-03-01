#set demangle-style none
set history save
set history filename ~/.gdb_history

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

