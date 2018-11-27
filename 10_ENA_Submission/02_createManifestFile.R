library(tidyverse)

# Set up a function
createManifestFile <- function(study, sample, assembly) {
  output <- tibble(STUDY = study,
                   SAMPLE = sample,
                   ASSEMBLYNAME = assembly,
                   COVERAGE = 20,
                   PROGRAM = "SPAdes",
                   PLATFORM = "Illumina MiSeq",
                   MOLECULETYPE = "genomic DNA",
                   FLATFILE = str_c("emblfiles/", assembly, ".embl.gz")) %>%
    gather(key = "ID", value = "value") %>%
    write_tsv(str_c("manifestfiles/", assembly, ".txt"), col_names = F)
  
} 

# Read in and apply to samples
samples <- read_tsv("sample_registration_receipt.csv") %>%
  separate(Accession, into = c("primary_acc", "secondary_acc"), sep = ' ')

# Apply to samples
map2(samples$primary_acc, samples$`Unique Name`, ~createManifestFile("PRJEB28838", .x, .y))

