*&---------------------------------------------------------------------*
*&  Include           Z_SALES_DATA
*&---------------------------------------------------------------------*

TABLES: vbak,
        vbap.

TYPES: BEGIN OF ty_orders,
         vbeln TYPE vbak-vbeln,
         posnr TYPE vbap-posnr,
         erdat TYPE vbak-erdat,
         matnr TYPE vbap-matnr,
         werks TYPE vbap-werks,
         netpr TYPE vbap-netpr,
       END OF ty_orders.

DATA: gt_orders TYPE STANDARD TABLE OF ty_orders,
      lt_erdat  TYPE cpt_soval,
      lt_vbeln  TYPE cpt_soval,
      lt_matnr TYPE  cpt_soval,
      ls_fieldcat TYPE slis_fieldcat_alv,
      lt_fieldcat TYPE slis_t_fieldcat_alv,
      i_layout   TYPE slis_layout_alv.
