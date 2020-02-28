
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
    download.file(binurl, destfile = tf)
    return(tf)
  } else {
    return(binurl)
  }
}

#' @export
insert_binary_to_drat <- function(pkg, last_tag = T) {
  origwd <- getwd()
  setwd(pkg)
  if(last_tag) {
    tags <- git2r::tags()
    lasttag <- tags[[length(tags)]]
    print(names(tags)[length(tags)])
    git2r::checkout(lasttag)
    print(git2r::status())
  }

  maccheck <- rhub::check_on_macos(pkg)
  wincheck <- rhub::check_on_windows(pkg)
  ubuntucheck <- rhub::check_on_ubuntu(pkg)

  drat::insertPackage(rhub_binary(maccheck, download = T))
  drat::insertPackage(rhub_binary(wincheck, download = T))
  drat::insertPackage(rhub_binary(ubuntucheck, download = T))

  if(last_tag) {
    git2r::checkout(pkg, branch = "master")
    print(git2r::status())
  }
  setwd(origwd)
}

