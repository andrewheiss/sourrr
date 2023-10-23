#' Determine starter feeding amounts based on ratios
#'
#' Generate measurements for feeding a starter based on starter:flour:water ratios like 1:4:4, 1:5:5, etc.
#'
#'
#' @param starter Numeric. Ratio of starter. (e.g., 1 in a 1:4:4 ratio.)
#' @param flour Numeric. Ratio of flour (e.g., 4 in a 1:4:4 ratio.)
#' @param water Numeric. Ratio of water (e.g., 4 in a 1:4:4 ratio.)
#' @param flour_g Amount of flour to use in the feeding
#'
#' @return Text printed to the console with feeding amounts.
#' @export
#'
#' @examples
#' feeding_from_ratio()
#'
#' # A 1:5:5 feeding with 50g of flour
#' feeding_from_ratio(
#'   starter = 1, flour = 5, water = 5,
#'   flour_g = 50
#' )
feeding_from_ratio <- function(starter = 1, flour = 4, water = 4, flour_g = 100) {
  pct <- starter / flour

  flour_amount <- flour_g
  water_amount <- flour_g * (water / flour)
  starter_amount <- flour_g * pct

  glue::glue(
    "{round(starter, 1)}:{round(flour, 1)}:{round(water, 1)}",
    "---",
    "{round(flour_amount, 1)}g flour",
    "{round(water_amount, 1)}g water",
    "{round(starter_amount, 1)}g starter",
    .sep = "\n"
  )
}
