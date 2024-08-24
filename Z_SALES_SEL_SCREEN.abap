*&---------------------------------------------------------------------*
*&  Include           Z_SALES_SEL_SCREEN
*&---------------------------------------------------------------------*

SELECTION-SCREEN: BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
SELECT-OPTIONS: s_vbeln FOR vbak-vbeln,
                s_matnr FOR vbap-matnr.
PARAMETERS: p_vkorg TYPE vbak-vkorg OBLIGATORY.
SELECT-OPTIONS: s_erdat FOR vbak-erdat.
SELECTION-SCREEN: END OF BLOCK b1.

SELECTION-SCREEN: BEGIN OF BLOCK b2 WITH FRAME TITLE text-002.
PARAMETERS: p_rad1 RADIOBUTTON GROUP rad,
            p_rad2 RADIOBUTTON GROUP rad,
            p_rad3 RADIOBUTTON GROUP rad.
SELECTION-SCREEN: END OF BLOCK b2.
