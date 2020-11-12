
rhub_binary <- function(check_object, download = TRUE) {
  check_id <- check_object$.__enclos_env__$private$ids_
  allchecks <- rhub::list_my_checks()
  thischeck_details <- allchecks[allchecks$id == check_id,]
  thischeck <- rhub::get_check(check_id)
  platform <- thischeck_details$platform[[1]]$`os-type`
  package_name <- thischeck_details$package
  package_version <- thischeck_details$version
  artifacts_url <- thischeck$urls()$artifacts
  # print(package_name)
  # print(package_version)
  # print(platform)
  # print(artifacts_url)
  ext <- switch (platform,
    "Windows" = ".zip",
    "Linux" = ".tar.gz",
    "macOS" = ".tgz"
  )
  binurl <- paste0(artifacts_url, "/", package_name, "_", package_version, ext)
  if(download) {
    td <- tempdir()
    tf <- paste0(td, "/", package_name, "_", package_version, ext)
    utils::download.file(binurl, destfile = tf)
    return(tf)
  } else {
    return(binurl)
  }
}

#' Put source and binary package into drat
#'
#'Build source and Mac binary bundle locally and Windows binary on rhub and put them into a drat repository.
#'
#' @param pkg path to package directory
#' @param last_tag whether to check out the latest tag (which should point to a release)
#' @param repodir directory containing drat repo. Looks for the `dratRepo` option, if not found, defaults to "~/github/drat"
#' @param build_win (TRUE) whether to build the Windows binary on rhub and put it into drat.
#'
#' @return TRUE on success
#' @examples
#' \dontrun{
#' insert_package_to_drat("~/github/czso", last_tag = T, build_win = T)
#' }
#' # ADD_EXAMPLES_HERE
#' @export
insert_package_into_drat <- function(pkg, last_tag = T,
                                   repodir = getOption("dratRepo", default = "~/github/drat"),
                                   build_win = T) {

  # note can use package_version() here for better sorting
  # i.e. names(tags) %>% str_remove("^v") %>% package_version() %>% max()

  origwd <- getwd()
  setwd(pkg)
  if(last_tag) {
    tags <- git2r::tags()
    lasttag <- tags[[length(tags)]]
    print(names(tags)[length(tags)])
    git2r::checkout(lasttag)
    print(git2r::status())
  }

  tryCatch({bin_build <- devtools::build(pkg, binary = T, args = c('--preclean'), vignettes = T, manual = T)
            drat::insertPackage(bin_build, repodir = repodir)}, error=function(e){})

  src_build <- devtools::build(pkg)
  drat::insertPackage(src_build, repodir = repodir)

  if(last_tag) {
    git2r::checkout(pkg, branch = "master")
    print(git2r::status())
  }

  # maccheck <- rhub::check_on_macos(src_build)

  # ubuntucheck <- rhub::check_on_ubuntu(src_build)
  # drat::insertPackage(rhub_binary(ubuntucheck, download = T), repodir = repodir)

  if(build_win) wincheck <- rhub::check_on_windows(src_build)

  if(build_win) drat::insertPackage(rhub_binary(wincheck, download = T), repodir = repodir)

  setwd(origwd)
  return(TRUE)
}

