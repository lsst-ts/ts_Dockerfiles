# Dual Linux Configuration

## Kernel Configuration Parameters Disabled

1. CONFIG_CPU_FREQ
2. CONFIG_CPU_IDLE
3. CONFIG_INPUT_PCSPKR
4. CONFIG_PCI_MSI

## Inconsistency with the Document

MOOG provides the document: LSST Kernel Software Build Procedure (OM-7403-103). However, there are some settings I can not find. List them below:

1. CONFIG_ACPI_PREPROCESSOR, the possible one is CONFIG_ACPI_PROCESSOR.
