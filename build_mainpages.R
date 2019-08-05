#Make main pages from navbar and mainpage files
navbar <- readLines('navbar.html')

navbar_index <- gsub("../","",navbar, fixed = TRUE) %>% 
    gsub(pattern = '<li><a href="index.html">',
         replacement = '<li class="active"><a href="index.html">',
         fixed = TRUE)

index <- readLines('mainpage.html')
new_index <- c(navbar_index[1:grep('<!--Mainpage-->',navbar)],
               index,
               navbar_index[grep('<!--/Mainpage-->',navbar):length(navbar)])
writeLines(new_index,"index.html")

navbar_download <- gsub(pattern = '<li><a href="../download/index.html">',
                        replacement = '<li class="active"><a href="../download/index.html">',
                        navbar,
                        fixed = TRUE)
index <- readLines('download/mainpage.html')
new_index <- c(navbar_download[1:grep('<!--Mainpage-->',navbar)],
               index,
               navbar_download[grep('<!--/Mainpage-->',navbar):length(navbar)])
writeLines(new_index,"download/index.html")

navbar_doc <- gsub(pattern = '<li><a href="../doc/index.html">',
                   replacement = '<li class="active"><a href="../doc/index.html">',
                   navbar,
                   fixed = TRUE)
index <- readLines('doc/mainpage.html')
new_index <- c(navbar_doc[1:grep('<!--Mainpage-->',navbar)],
               index,
               navbar_doc[grep('<!--/Mainpage-->',navbar):length(navbar)])
writeLines(new_index,"doc/index.html")