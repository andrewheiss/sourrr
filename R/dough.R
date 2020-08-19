#' Build a sourdough recipe from final weight
#'
#' Generate a recipe based on the final target weight of the loaf dough.
#'
#' Salt is currently just added on as extra because I couldn't figure out the
#' math for it :shrug: (i.e. specifying a 800g final loaf will result in 809g
#' with 2% salt because it just adds it to the 800g)
#'
#' @param final_weight Numeric. Target weight for dough, in grams. This won't be
#'   completely accurate because salt is added to the final mass. See Details
#'   for more information.
#' @param hydration Numeric. Hydration for dough, in percent. Defaults to 0.7 (70%).
#' @param pct_starter Numeric. Percentage of starter for dough. Defaults to 0.25 (25%).
#' @param starter_hydration Numeric. Level of hydration of starter. Defaults to 1 (100%).
#' @param pct_salt Numeric. Percentage of salt for dough. Defaults to 0.02 (2%)
#'
#' @return Text printed to the console with a recipe.
#' @export
#'
#' @examples
#' build_recipe(final_weight = 1000)
#'
#' build_recipe(final_weight = 880,
#'                     hydration = 0.74,
#'                     pct_starter = 0.2,
#'                     starter_hydration = 1,
#'                     pct_salt = 0.02)
build_recipe <- function(final_weight, hydration = 0.7,
                         pct_starter = 0.25, starter_hydration = 1,
                         pct_salt = 0.02) {
  total_water <- (final_weight * hydration) / (1 + hydration)
  total_flour <- final_weight - total_water
  total_salt <- total_flour * pct_salt

  total_starter <- total_flour * pct_starter
  total_starter_water <- (total_starter * starter_hydration) / (1 + starter_hydration)
  total_starter_flour <- (total_starter * starter_hydration) / (1 + starter_hydration)

  final_water <- total_water - total_starter_water
  final_flour <- total_flour - total_starter_flour

  final_hydration <- total_water / total_flour

  actual_final_weight <- total_water + total_flour + total_salt

  format_recipe(flour = final_flour, total_flour = total_flour,
                water = final_water, total_water = total_water,
                starter = total_starter, starter_hydration = starter_hydration,
                starter_flour = total_starter_flour, starter_water = total_starter_water,
                pct_starter = pct_starter, salt = total_salt, pct_salt = pct_salt,
                final_hydration = final_hydration, final_weight = actual_final_weight)
}


#' Calculate the hydration of a given recipe
#'
#' Determine the hydration of a recipe, given its proportions of water, flour,
#' starter, and salt.
#'
#' @param flour Numeric. Amount of flour, in grams.
#' @param water Numeric. Amount of water, in grams.
#' @param starter Numeric. Amount of starter, in grams.
#' @param starter_hydration Numeric. Level of hydration of starter, in percent
#'   (1 = 100%)
#' @param salt Numeric. Amount of salt, in grams.
#'
#' @return Text printed to the console with a recipe.
#' @export
#'
#' @examples
#' calculate_recipe(flour = 450,
#'                  water = 320,
#'                  starter = 100,
#'                  starter_hydration = 1,
#'                  salt = 8)
calculate_recipe <- function(flour, water, starter, starter_hydration, salt) {
  starter_water <- (starter * starter_hydration) / (1 + starter_hydration)
  starter_flour <- (starter * starter_hydration) / (1 + starter_hydration)

  total_water <- water + starter_water
  total_flour <- flour + starter_flour

  final_hydration <- total_water / total_flour
  pct_salt <- salt / total_flour
  pct_starter <- starter / total_flour

  actual_final_weight <- total_water + total_flour + salt

  format_recipe(flour = flour, total_flour = total_flour, water = water, total_water = total_water,
                starter = starter, starter_hydration = starter_hydration,
                starter_flour = starter_flour, starter_water = starter_water,
                pct_starter = pct_starter, salt = salt, pct_salt = pct_salt,
                final_hydration = final_hydration, final_weight = actual_final_weight)
}


#' Make a recipe pretty
#'
#' @keywords internal
#' @noRd
format_recipe <- function(flour, total_flour, water, total_water,
                          starter, starter_hydration, starter_flour,
                          starter_water, pct_starter, salt, pct_salt,
                          final_hydration, final_weight) {
  glue::glue("{round(flour, 0)}g flour ({round(total_flour, 1)}g total; ",
             "{round(starter_water, 1)}g from starter)\n",
             "{round(water, 0)}g water ({round(total_water, 1)}g total; ",
             "{round(starter_flour, 1)}g from starter)\n",
             "{round(starter, 0)}g starter ({round(pct_starter * 100, 1)}%; ",
             "{round(starter_hydration * 100, 1)}% hydration)\n",
             "{round(salt, 0)}g salt ({round(pct_salt * 100, 1)}%)\n---\n",
             "{round(final_hydration * 100, 1)}% hydration\n",
             "{round(final_weight, 0)}g final loaf")
}
