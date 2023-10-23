@AbapCatalog.sqlViewName: 'Z3250_V_001'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Eğitimi Ödevi'
define view Z3250_CDS_001
as select from ekko
    inner join ekpo on ekpo.ebeln = ekko.ebeln
    inner join mara on mara.matnr = ekpo.matnr
    inner join makt on makt.matnr = mara.matnr
                   and makt.spras = $session.system_language
    inner join lfa1 on lfa1.lifnr = ekko.lifnr
 {
    ekpo.ebeln,
    ekpo.ebelp,
    ekpo.matnr,
    makt.maktx,
    ekpo.werks,
    ekpo.lgort,
    ekpo.meins,
    lfa1.lifnr,
    lfa1.stras,
    lfa1.mcod3,
    concat( lfa1.stras, concat(', '  ,lfa1.mcod3 ) ) as ad1
}
