class zcl_oop_val_invoice definition
  public
  inheriting from zcl_oop_doc_base
  final
  create public .

  public section.
  protected section.
    methods validate_specific_rules redefinition.

  private section.
endclass.



class zcl_oop_val_invoice implementation.

  method validate_specific_rules.

    if is_invoice-amount < 0.
      rv_error = 'An invoice amount must be positive'.
    endif.

  endmethod.

endclass.
