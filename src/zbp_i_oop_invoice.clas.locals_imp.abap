class lhc_Invoice definition inheriting from cl_abap_behavior_handler.
  private section.

    methods get_instance_authorizations for instance authorization
      importing keys request requested_authorizations for Invoice result result.

    methods get_global_authorizations for global authorization
      importing request requested_authorizations for Invoice result result.

    methods validateOORules for validate on save
      importing keys for Invoice~validateOORules.

endclass.

class lhc_Invoice implementation.

  method get_instance_authorizations.
  endmethod.

  method get_global_authorizations.
  endmethod.

  method validateOORules.

    " 1. buffer reading for the target instances to be saved
    read entities of zi_oop_invoice in local mode
      entity Invoice
      fields ( Amount DcIndicator Description VendorId ) with corresponding #( keys )
      result data(lt_invoices).

    loop at lt_invoices into data(ls_invoice).

      try.
          " 2. factory request, providing DcIndicator, returning correct object type
          data(lo_validator) = zcl_oop_doc_factory=>get_instance( iv_doc_type = ls_invoice-DcIndicator ).

          " 3. RAP structure conversion (Type Entity) to expected by the interface (DB)
          data(ls_invoice_db) = corresponding zoop_invoice( ls_invoice ).

          " 4. Validates all document type;
          data(lv_error) = lo_validator->validate_document( is_invoice = ls_invoice_db ).

          " 5. If the validation returns an error -> forward to RAP structures
          if lv_error is not initial.
            append value #( %tky = ls_invoice-%tky ) to failed-invoice.
            append value #( %tky = ls_invoice-%tky
                            %msg = new_message( id       = 'SY'
                                                number   = '002'
                                                severity = if_abap_behv_message=>severity-error
                                                v1       = lv_error )
                          ) to reported-invoice.
          endif.

          " 6. If the document indicator is invalid => custom exception throw
        catch zcx_oop_doc_exception into data(lx_exception).
          append value #( %tky = ls_invoice-%tky ) to failed-invoice.
          append value #( %tky = ls_invoice-%tky
                          %msg = new_message( id       = 'SY'
                                              number   = '002'
                                              severity = if_abap_behv_message=>severity-error
                                              v1       = 'Invalid document type indicator: '
                                              v2       = lx_exception->mv_doctype )
                        ) to reported-invoice.
      endtry.

    endloop.

  endmethod.

endclass.
