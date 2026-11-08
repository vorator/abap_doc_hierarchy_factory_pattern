class zcx_oop_doc_exception definition
  public
  inheriting from cx_static_check
  final
  create public .

  public section.
    interfaces if_t100_message.

    data mv_doctype type zoop_invoice-dc_indicator.

    methods constructor
      importing
        textid      like if_t100_message=>default_textid optional
        previous    like previous optional
        iv_doctype  type zoop_invoice-dc_indicator.

  protected section.
  private section.
endclass.

class zcx_oop_doc_exception implementation.

  method constructor ##ADT_SUPPRESS_GENERATION.
    call method super->constructor
      exporting
        previous = previous.
    me->mv_doctype = iv_doctype.
  endmethod.

endclass.
