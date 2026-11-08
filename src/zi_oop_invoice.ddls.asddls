@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Main consumption view for invoice table'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_OOP_INVOICE 
  as select from zoop_invoice
{
  key invoice_id  as InvoiceId,
  vendor_id       as VendorId,
  vendor_name     as VendorName,
  @Semantics.amount.currencyCode: 'Currency'
  amount          as Amount,
  currency        as Currency,
  invoice_date    as InvoiceDate,
  dc_indicator    as DcIndicator,
  status          as Status,
  description     as Description,
  created_by      as CreatedBy,
  created_at      as CreatedAt,
  modified_by     as ModifiedBy,
  modified_at     as ModifiedAt
}
