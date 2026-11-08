class zcl_oop_doc_factory definition
  public
  final
  create public .

  public section.

    class-methods get_instance
      importing
        iv_doc_type type zoop_invoice-dc_indicator
      returning
        value(ro_validator) type ref to zif_oop_doc_validator
      raising
        zcx_oop_doc_exception.

  protected section.
  private section.
endclass.

class zcl_oop_doc_factory implementation.

  method get_instance.

    case iv_doc_type.
      when 'C'. "Invoice
        ro_validator = new zcl_oop_val_invoice(  ).

      when 'D'.  "Credit-Note
        ro_validator = new zcl_oop_val_credit(  ).

      " when ...
      when others.
        raise exception type zcx_oop_doc_exception
          exporting
            iv_doctype = iv_doc_type.
    endcase.

  endmethod.

endclass.
