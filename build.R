invisible(file.remove("_main.Rmd")) # Clean up in case previous build failed
unlink("site/figures", recursive = T)

# Renders the book to HTML
bookdown::render_book("_bookdown.yml", "bookdown::gitbook", output_dir = "site")

# Post-Build Steps -------------------------------------------------------------

file.rename("site/presenting.html", "site/index.html") # The root page

# GitHub pages apparently doesn't like directories that start with underscores,
# so replacing "_main_fils" with "figures". Rename directory and replace in
# paths in ths *.html files

file.rename("site/_main_files", "site/figures")
html_files <- list.files("site", "*.html", full.names = T)

for (html_file in html_files) {
  file_contents <- readr::read_file(html_file)
  
  # Replace all references to "_main_files" with "figures"
  new_contents <- gsub("_main_files", "figures", file_contents, fixed = TRUE)
  
  # Also need to replace links/references to "presenting.html" with "index.html"
  new_contents <- gsub("presenting\\.html", "index\\.html", new_contents)
  readr::write_file(new_contents, html_file)
}
