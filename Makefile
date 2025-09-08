AS = aarch64-linux-gnu-as
LD = aarch64-linux-gnu-ld
OBJCOPY = aarch64-linux-gnu-objcopy
OBJDUMP = aarch64-linux-gnu-objdump

ASFLAGS = -g
LDFLAGS = -T linker.ld

SRC_DIR = src
BUILD_DIR = build
TARGET = $(BUILD_DIR)/program

SOURCES = $(wildcard $(SRC_DIR)/*.asm)
OBJECTS = $(SOURCES:$(SRC_DIR)/%.asm=$(BUILD_DIR)/%.o)

all: $(TARGET).elf $(TARGET).bin

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.asm | $(BUILD_DIR)
	$(AS) $(ASFLAGS) $< -o $@

$(TARGET).elf: $(OBJECTS)
	$(LD) $(LDFLAGS) $(OBJECTS) -o $@

$(TARGET).bin: $(TARGET).elf
	$(OBJCOPY) -O binary $< $@

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

disasm: $(TARGET).elf
	$(OBJDUMP) -d $< > $(BUILD_DIR)/disassembly.txt

clean:
	rm -rf $(BUILD_DIR)

debug: $(TARGET).elf
	qemu-system-aarch64 -machine virt -cpu cortex-a53 -nographic -kernel $(TARGET).elf -S -gdb tcp::1234

.PHONY: all clean disasm debug