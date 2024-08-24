*&---------------------------------------------------------------------*
*& Report  Z_SALES_ORD_REP
*& Author - Harsh Sharma
*&---------------------------------------------------------------------*

REPORT z_sales_ord_rep.
" INCLUDEs chain for various purpose.
INCLUDE: z_sales_data,      "data definitions
         z_sales_sel_screen,"selection screen
         z_sales_form.      "subroutines

START-OF-SELECTION.
*  lt_erdat[] = s_erdat[].       why are we not using it ??
  MOVE-CORRESPONDING: s_erdat[] TO lt_erdat[],
                      s_matnr[] TO lt_matnr[],
                      s_vbeln[] TO lt_vbeln[].

  PERFORM f_select_orders USING   lt_erdat   "subroutine for selecting the orders
                                  p_vkorg
                                  lt_vbeln
                                  lt_matnr
                         CHANGING gt_orders.

  PERFORM f_create_catalog.                  "creating catalog to be used for these
  PERFORM f_layout_create.                   "creating layout

  IF p_rad1 IS NOT INITIAL.
    PERFORM f_classic_alv.                  "LIST ALV
  ELSEIF p_rad2 IS NOT INITIAL.
    PERFORM f_grid_display.                "GRID DISPLAY
  ELSE.
    PERFORM f_popup_display.              "Pop up display
  ENDIF.
