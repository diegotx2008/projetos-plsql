
  CREATE MATERIALIZED VIEW "SANKHYA"."MVW_AD_PLANKITVW" ("NUMCONTRATO", "NUNICO", "NOMEKIT", "SEQ", "SEQK", "CODPROD", "CODUSU", "QTDKIT", "DHALTER", "GRUPO", "TIPO")
  SEGMENT CREATION IMMEDIATE
  ORGANIZATION HEAP PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SANKHYA" 
  BUILD IMMEDIATE
  USING INDEX 
  REFRESH FORCE ON DEMAND START WITH sysdate+0 NEXT SYSDATE + (90+ 1440 - ( ((To_char(SYSDATE, 'HH24')*60)+To_char(SYSDATE, 'MI'))))/60/24
  USING DEFAULT LOCAL ROLLBACK SEGMENT
  USING ENFORCED CONSTRAINTS DISABLE ON QUERY COMPUTATION DISABLE QUERY REWRITE
  AS SELECT DISTINCT KIT.numcontrato,
                   KIT.nunico,
                   KIT.nomekit,
                   KIT.seq,
                   KIT.seqk,
                   ROL.codprod,
                   KIT.codusukit   AS CODUSU,
                   SUM(KIT.qtdkit) AS QTDKIT,
                   KIT.dhalter,
                   ROL.codgrupoprod,
                   KIT.tipo
   FROM   ad_planrolkit KIT
          inner join ad_planrol ROL
                  ON ROL.numcontrato = KIT.numcontrato
                     AND ROL.nunico = KIT.nunico
                     AND KIT.seq = ROL.seq
   GROUP  BY KIT.numcontrato,
             KIT.nunico,
             KIT.nomekit,
             KIT.seqk,
             KIT.seq,
             ROL.codprod,
             KIT.codusukit,
             KIT.dhalter,
             ROL.codgrupoprod,
             KIT.tipo
   UNION ALL
   SELECT DISTINCT ROL.numcontrato,
                   ROL.nunico,
                   'AVULSO'                                          AS NOMEKIT,
                   ROL.seq,
                   ROL.seq,
                   ROL.codprod,
                   0                                                 AS CODUSU,
                   SUM(ROL.qtdnego) - (SELECT Nvl(SUM(KIT.qtdkit), 0)
                                       FROM   ad_planrolkit KIT
                                       WHERE  ROL.numcontrato = KIT.numcontrato
                                              AND ROL.nunico = KIT.nunico
                                              AND KIT.seq = ROL.seq) AS QTDKIT,
                   SYSDATE                                           AS DHALTER,
                   ROL.codgrupoprod,
                   'A'                                               AS TIPO
   FROM   ad_planrol ROL
   ---LEFT JOIN AD_PLANROLKIT KIT ON ROL.NUMCONTRATO = KIT.NUMCONTRATO AND ROL.NUNICO = KIT.NUNICO AND KIT.SEQ = ROL.SEQ
   WHERE  ROL.principal = 'SIM'
          AND EXISTS (SELECT 1
                      FROM   ad_planrolkit KIT
                      WHERE  ROL.numcontrato = KIT.numcontrato
                             AND ROL.nunico = KIT.nunico)
   GROUP  BY ROL.numcontrato,
             ROL.nunico,
             ROL.seq,
             ROL.seq,
             ROL.codprod,
             ROL.nunota,
             ROL.codgrupoprod
   HAVING SUM(ROL.qtdnego) - (SELECT Nvl(SUM(KIT.qtdkit), 0)
                              FROM   ad_planrolkit KIT
                              WHERE  ROL.numcontrato = KIT.numcontrato
                                     AND ROL.nunico = KIT.nunico
                                     AND KIT.seq = ROL.seq) > 0
   UNION ALL
   SELECT DISTINCT ROL.numcontrato,
                   ROL.nunico,
                   'AVULSO'         AS NOMEKIT,
                   ROL.seq,
                   ROL.seq,
                   ROL.codprod,
                   0                AS CODUSU,
                   SUM(ROL.qtdnego) AS QTDKIT,
                   SYSDATE          AS DHALTER,
                   ROL.codgrupoprod,
                   'A'              AS TIPO
   FROM   ad_planrol ROL
   WHERE  ROL.principal = 'SIM'
          AND NOT EXISTS (SELECT 1
                          FROM   ad_planrolkit KIT
                          WHERE  ROL.numcontrato = KIT.numcontrato
                                 AND ROL.nunico = KIT.nunico)
   GROUP  BY ROL.numcontrato,
             ROL.nunico,
             ROL.seq,
             ROL.seq,
             ROL.codprod,
             ROL.nunota,
             ROL.codgrupoprod
   ;

   COMMENT ON MATERIALIZED VIEW "SANKHYA"."MVW_AD_PLANKITVW"  IS 'snapshot table for snapshot SANKHYA.MVW_AD_PLANKITVW';

