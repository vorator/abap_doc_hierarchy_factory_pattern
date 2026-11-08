interface zif_oop_doc_validator
  public .

  methods validate_document
    importing
      is_invoice type zoop_invoice
    returning value(rv_error_msg) type string.

endinterface.
