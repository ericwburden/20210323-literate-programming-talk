bookdown::render_book("_bookdown.yml", "bookdown::gitbook", output_dir = "docs")

# Post-Build Steps -------------------------------------------------------------

file.rename("docs/presenting.html", "docs/index.html") # The root page

# GitHub pages apparently doesn't like directories that start with underscores,
# so replacing "_main_fils" with "figures". Rename directory and replace in
# paths in ths *.html files

file.rename("docs/_main_files", "docs/figures")
html_files <- list.files("docs", "*.html", full.names = T)

for (html_file in html_files) {
  file_contents <- readr::read_file(html_file)
  new_contents <- gsub("_main_files", "figures", file_contents)
  readr::write_file(new_contents, html_file)
}
