@AbapCatalog.sqlViewName: 'Z3250_V_002'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Eğitimi Ödevi 2'
define view Z3250_CDS_002
as select from vbrp
    inner join vbrk on vbrk.mandt = vbrp.mandt
                   and vbrk.vbeln = vbrp.vbeln
    inner join mara on mara.mandt = vbrp.mandt
                   and mara.matnr = vbrp.matnr
    left outer join vbak on vbak.vbeln = vbrp.aubel
    left outer join kna1 on kna1.kunnr = vbak.kunnr
                        and kna1.mandt = vbrp.mandt
    left outer join makt on makt.matnr = mara.matnr
                        and makt.mandt = vbrp.mandt
                        and makt.spras = $session.system_language
    {
    vbrp.vbeln,
    vbrp.posnr,
    vbrp.aubel,
    vbrp.aupos,
    vbak.kunnr,
    concat(kna1.name1, concat(' '  ,kna1.name2)) as kunnrAd,
    left(kna1.kunnr, 3) as left_kunnr, 
    length(vbrp.matnr)  as matnr_length,
    
    @EndUserText.label: 'Faturalama Türü'
    cast( case vbrk.fkart
            when 'FAS'
                then 'Peşinat talebi iptali'
            when 'FAZ'
                then 'Peşinat talebi'
            else 
                 'Fatura'
            end as char20 ) as Fattur,
    vbrk.fkdat,
    currency_conversion( amount => vbrk.netwr,
                         source_currency => vbrk.waerk,
                         target_currency => cast('EUR' as abap.cuky),
                         exchange_rate_date => vbrk.fkdat ) as conversion_netwr
    }
    
