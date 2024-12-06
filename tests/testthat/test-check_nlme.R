test_that("check_nlme Model assumptions are checked", {
  expect_equal(check_nlme(model = NULL), "Error in check_nlme(model = NULL) : Specify a model to check.")
})
