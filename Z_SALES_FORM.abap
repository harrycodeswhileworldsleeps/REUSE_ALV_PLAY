*&---------------------------------------------------------------------*
*&  Include           Z_SALES_FORM
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  F_SELECT_ORDERS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_select_orders USING i_erdat TYPE cpt_soval
                           i_vkorg TYPE vkorg
                           i_vbeln TYPE cpt_soval
                           i_matnr TYPE cpt_soval
                  CHANGING r_sales LIKE gt_orders.
  SELECT a~vbeln,
         a~erdat,
         b~posnr,
         b~matnr,
         b~werks,
         b~netpr
  FROM   vbak AS a INNER JOIN
         vbap AS b ON
         a~vbeln = b~vbeln
  WHERE  a~vkorg = @i_vkorg
  AND    a~vbeln IN @i_vbeln
  AND    b~matnr IN @i_matnr
  AND    a~erdat IN @i_erdat
  INTO CORRESPONDING FIELDS OF TABLE @gt_orders.
  IF sy-subrc <> 0.
    MESSAGE 'no data available' TYPE 'e'.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  F_LAYOUT_CREATE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_layout_create .
  i_layout-colwidth_optimize = 'X'.
  i_layout-zebra = 'X'.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  F_CREATE_CATALOG
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_create_catalog .

  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'VBELN'.
  ls_fieldcat-tabname   = 'GT_ORDERS'.
  ls_fieldcat-key       = 'X'.
  ls_fieldcat-seltext_m = 'Sales Order'.
  APPEND ls_fieldcat TO lt_fieldcat.

  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'POSNR'.
  ls_fieldcat-tabname   = 'GT_ORDERS'.
  ls_fieldcat-seltext_m = 'Item'.
  APPEND ls_fieldcat TO lt_fieldcat.

  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'ERDAT'.
  ls_fieldcat-tabname   = 'GT_ORDERS'.
  ls_fieldcat-seltext_m = 'Created On'.
  APPEND ls_fieldcat TO lt_fieldcat.

  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'MATNR'.
  ls_fieldcat-tabname   = 'GT_ORDERS'.
  ls_fieldcat-seltext_m = 'Materials'.
  APPEND ls_fieldcat TO lt_fieldcat.

  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'WERKS'.
  ls_fieldcat-tabname   = 'GT_ORDERS'.
  ls_fieldcat-seltext_m = 'Plants'.
  APPEND ls_fieldcat TO lt_fieldcat.

  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'NETPR'.
  ls_fieldcat-tabname   = 'GT_ORDERS'.
  ls_fieldcat-seltext_m = 'Net price'.
  APPEND ls_fieldcat TO lt_fieldcat.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  F_CLASSIC_ALV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_classic_alv.
  CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      it_fieldcat        = lt_fieldcat
      is_layout          = i_layout
    TABLES
      t_outtab           = gt_orders
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.
  IF sy-subrc <> 0.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  F_GRID_DISPLAY
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_grid_display .
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      it_fieldcat        = lt_fieldcat
      is_layout          = i_layout
    TABLES
      t_outtab           = gt_orders.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  F_POPUP_DISPLAY
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_popup_display .
  CALL FUNCTION 'REUSE_ALV_POPUP_TO_SELECT'
    EXPORTING
      i_title              = 'Demo Shit'
      i_allow_no_selection = 'X'
      i_zebra              = 'X'
      i_tabname            = 'GT_ORDERS'
      it_fieldcat          = lt_fieldcat
    TABLES
      t_outtab             = gt_orders
    EXCEPTIONS
      program_error        = 1
      OTHERS               = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.
ENDFORM.
