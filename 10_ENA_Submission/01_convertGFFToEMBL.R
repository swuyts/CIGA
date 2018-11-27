library(tidyverse)
library(readODS)

# Read in the labnames file
labnames <- read_csv("../03_quality_control/labnames_and_origins.csv") %>%
  mutate(PrevName = str_replace(PrevName, "/", "-"),
         PrevName = str_replace(PrevName, " ", "-"),
         Labname = str_replace(Labname, "AMB-F", "AMBF")) %>%
  # Add species names
  left_join(read_ods("../03_quality_control/Table_ch3_curated.ods") %>% rename(Labname = Strain) %>% mutate(Labname = str_replace(Labname, "AMB-F", "AMBF")))


# Read in the sample registration receipt file from EMBL after sample registration and create the necessary variables
samples <- read_tsv("sample_registration_receipt.csv") %>%
  left_join(labnames %>% rename(`Unique Name`= Labname)) %>%
  mutate(path_to_fna = str_c("/media/harddrive/sander/carrot_isolates/04_annotation/out/", PrevName, "/", PrevName, ".fna"),
         path_to_gff = str_c("/media/harddrive/sander/carrot_isolates/04_annotation/out/", PrevName, "/", PrevName, ".gff"),
         project = "PRJEB28838",
         locus_tag = "CJF",
         output = str_c("/media/harddrive/sander/carrot_isolates/12_ENA_Submission/emblfiles/", `Unique Name`, ".embl")) %>%
  mutate(Classification = str_replace(Classification, "putative ", ""))


# Run bash command
command <- samples %>%
  mutate(command = str_c("scripts/convertGFFToEMBL.sh",
                         path_to_fna,
                         path_to_gff,
                         project,
                         locus_tag,
                         str_replace(Classification, " ", "_"),
                         `Unique Name`,
                         output,
                         sep = " ")) %>%
  pull(command)

# Run commands
for (x in command){
  system(x)
}
