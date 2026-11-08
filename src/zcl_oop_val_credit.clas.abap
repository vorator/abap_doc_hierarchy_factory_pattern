class zcl_oop_val_credit definition
  public
  inheriting from zcl_oop_doc_base
  final
  create public .

  public section.
  protected section.
    methods validate_specific_rules redefinition.

  private section.
endclass.



class zcl_oop_val_credit implementation.

  method validate_specific_rules.

    if is_invoice-amount > 0.
      rv_error = 'A credit-note amount must be negative'.
      return.
    endif.

    if is_invoice-description is initial.
      rv_error = 'The description cannot be empty. Relate invoice mandatory'.
      return.
    endif.

  endmethod.

endclass.
