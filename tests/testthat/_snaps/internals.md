# internal result binding warns when every result is empty

    Code
      bound <- igo_bind_results(list(NULL, NULL), "No results.")
    Condition
      Warning:
      No results.

# internal status validation reports invalid values only

    Code
      igo_warn_invalid_status(c("Full Membership", "Invalid"), valid_status)
    Condition
      Warning:
      Unknown values for `status`: 'Invalid'. Valid values are 'No Membership', 'Full Membership'.

