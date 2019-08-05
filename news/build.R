library(magrittr)
#rebuild news for all versions:
top <- readLines("./news/top")
news <- readLines(system.file("NEWS.html", package = "Metaboseek"))
news <- news[grep("<body>",news)[1]:length(news)]

writeLines(c(top, news),"./news/index.html")

currentVer <- paste(strsplit(paste(packageVersion("Metaboseek")[[1]]),
                             "\\.")[[1]][1:3],collapse = ".")

folders <- list.dirs("./integrated")
if(!paste0("./integrated/",currentVer) %in% folders){
 dir.create(paste0("./integrated/",currentVer))
    folders <- c(folders, paste0("./integrated/",currentVer))
}

lapply(folders, function(x){
    file.copy("./news/index.html",file.path(x,"index.html"),overwrite = TRUE)
    })






#update news on download site
news <- readLines(system.file("NEWS.html", package = "Metaboseek"))
newsinsert <-  news[grep('<!-- START INSERT -->',news):grep('<!-- END INSERT -->',news)]
download <- readLines('download/index.html')
new_download <- c(download[1:(grep('<!-- START INSERT -->',download)-1)],
                  newsinsert,
                  download[(grep('<!-- END INSERT -->',download)+1):length(download)])
#writeLines(new_download,"download.html")
writeLines(new_download,"download/index.html")


#update the install_Metaboseek script
file.copy(system.file("scripts/install_Metaboseek.R", package = "Metaboseek"),
          file.path("files/install_Metaboseek.R"), overwrite = TRUE)


#Build documentation based on latest master version:
download.file("https://raw.githubusercontent.com/mjhelf/METABOseek/master/vignettes/Getting_Started.Rmd",
              "./doc/temp.Rmd")

#note: images, etc have to be placed in ./doc folder manually
library(rmarkdown)
rmarkdown::render(file.path(getwd(),"doc/temp.Rmd"),
       output_format = "html_document", output_file = "Getting_Started.html",
       output_dir = NULL,
       output_options = list(
           css = "style.css",
           theme = "simplex",
           toc = TRUE,
           number_sections = TRUE,
           toc_depth = 2,
           toc_float = list(collapsed = FALSE, smooth_scroll = TRUE)),
       intermediates_dir = NULL,
       knit_root_dir = NULL, runtime = c("auto", "static", "shiny",
                                         "shiny_prerendered"), clean = TRUE, params = NULL,
       knit_meta = NULL, envir = parent.frame(), run_pandoc = TRUE,
       quiet = FALSE, encoding = "UTF-8")
