@AbapCatalog.sqlViewName: 'Z3250_V_003'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Eğitimi Ödev 2 2. CDS'
define view Z3250_CDS_003 as select from z3250_v_002
    inner join vbrk on vbrk.mandt = z3250_v_002.mandt
                   and vbrk.vbeln = z3250_v_002.vbeln
    {
    z3250_v_002.vbeln,
    sum( conversion_netwr )                                         as toplam_net,
    kunnrad,
    count(distinct posnr ) as toplam_fatura,
    division(cast( sum(conversion_netwr) as abap.curr( 10, 3 ) ), 
             cast( count(distinct posnr ) as abap.int1 ), 3)        as Ortalama_Mkt,
    z3250_v_002.fkdat,
    left(vbrk.inco2_l,3)                                            as incoterm_yer,
    left(z3250_v_002.fkdat,4)                                       as Faturalama_Yili,
    substring(z3250_v_002.fkdat,5,2)                                as Faturalama_Ayi,
    substring(z3250_v_002.fkdat,7,2)                                as Faturalama_Gunu
    }
    group by z3250_v_002.vbeln,
             z3250_v_002.kunnrad,
             z3250_v_002.fkdat,
             vbrk.inco2_l;
