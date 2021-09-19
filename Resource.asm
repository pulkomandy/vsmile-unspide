
// Resource Table
// Created by IDE, Do not modify this table

.TEXT
.public _RES_Table;
.external __RES_FONT_BIN_sa
.public _RES_FONT_BIN_SA;


_RES_Table:

_RES_FONT_BIN_SA:
	.DW offset __RES_FONT_BIN_sa,seg __RES_FONT_BIN_sa;


// End Table
