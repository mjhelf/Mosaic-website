install.packages("remotes")

try({remove.packages("BiocInstaller")})

if (!requireNamespace("BiocManager", quietly = TRUE)){
  install.packages("BiocManager")}

BiocManager::install(c("xcms", "CAMERA","BiocParallel"), update = TRUE, ask = FALSE)

#devtools::install_github("berlinguyinca/spectra-hash", subdir="splashR")
remotes::install_github("mjhelf/Rdisop")  ##forked from "sneumann/Rdisop"; forked version will not change and should always work. Will change once new Rdisop version is in bioc-release
remotes::install_github("mjhelf/MassTools")

install.packages("shinyFiles")


remotes::install_github("mjhelf/Metaboseek",
                        dependencies = NA, #will not include suggests (rcdk et al)
                        ref = if(length(commandArgs(trailingOnly=TRUE)) > 0 ){
                          commandArgs(trailingOnly=TRUE)[1]
                        }else{
                          "master"
                        })


## Start Metaboseek; this is all you need to run once you have installed Mosaic.
library(Metaboseek)

runMseek(launch.browser = T)