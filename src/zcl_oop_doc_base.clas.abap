class zcl_oop_doc_base definition
  public
  abstract
  create public .

  public section.
    interfaces zif_oop_doc_validator.

  protected section.
    methods validate_specific_rules abstract
      importing
        is_invoice type zoop_invoice
      returning value(rv_error) type string.

  private section.
endclass.

class zcl_oop_doc_base implementation.

  method zif_oop_doc_validator~validate_document.

    if is_invoice-vendor_id is initial.
      rv_error_msg = 'Vendor ID is mandatory for all documents.'.
      return.
    endif.

    if is_invoice-amount = 0.
      rv_error_msg = 'An Invoice cannot have zero amount'.
      return.
    endif.

    rv_error_msg = validate_specific_rules( is_invoice ).

  endmethod.

endclass.
