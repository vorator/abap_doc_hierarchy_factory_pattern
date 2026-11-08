class ltcl_factory_test definition final for testing
  duration short
  risk level harmless.

  private section.
    " scenario definion
    methods:
      test_valid_invoice       for testing,
      test_invalid_invoice     for testing,
      test_invalid_credit_note for testing,
      test_invalid_doc_type    for testing.
endclass.

class ltcl_factory_test implementation.

  method test_valid_invoice.
    " 1. Simulation data
    data(ls_invoice) = value zoop_invoice( dc_indicator = 'C' amount = 100 vendor_id = 'VD01' ).

    try.
        " 2. Factory invocation
        data(lo_validator) = zcl_oop_doc_factory=>get_instance( 'C' ).
        data(lv_error) = lo_validator->validate_document( ls_invoice ).

        " 3. Assert
        cl_abap_unit_assert=>assert_initial( act = lv_error
                                             msg = 'Invoice with positive amount; should not generate error.' ).
      catch zcx_oop_doc_exception.
        cl_abap_unit_assert=>fail( 'Should not return exception for type C.' ).
    endtry.
  endmethod.

  method test_invalid_invoice.
    " Invoice with negative amount
    data(ls_invoice) = value zoop_invoice( dc_indicator = 'C' amount = -50 vendor_id = 'VD01' ).

    try.
        data(lo_validator) = zcl_oop_doc_factory=>get_instance( 'C' ).
        data(lv_error) = lo_validator->validate_document( ls_invoice ).

        cl_abap_unit_assert=>assert_not_initial( act = lv_error
                                                 msg = 'Invoice with negative, must return an error.' ).
      catch zcx_oop_doc_exception.
        cl_abap_unit_assert=>fail( 'Should not return exception for type C.' ).
    endtry.
  endmethod.

  method test_invalid_credit_note.
    " Credit note with positive amount
    data(ls_invoice) = value zoop_invoice( dc_indicator = 'D' amount = 50 vendor_id = 'VD01' ).

    try.
        data(lo_validator) = zcl_oop_doc_factory=>get_instance( 'D' ).
        data(lv_error) = lo_validator->validate_document( ls_invoice ).

        cl_abap_unit_assert=>assert_not_initial( act = lv_error
                                                 msg = 'Credit-note with positive amount; must return an error.' ).
      catch zcx_oop_doc_exception.
        cl_abap_unit_assert=>fail( 'Should not return exception for type D.' ).
    endtry.
  endmethod.

  method test_invalid_doc_type.
    try.
        " Attempt to create an invalid type
        zcl_oop_doc_factory=>get_instance( 'X' ).

        cl_abap_unit_assert=>fail( 'Factory should throw an exception for X type.' ).

      catch zcx_oop_doc_exception into data(lx_ex).
        cl_abap_unit_assert=>assert_equals( exp = 'X' act = lx_ex->mv_doctype ).
    endtry.
  endmethod.

endclass.

