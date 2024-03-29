﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="pgeCreateReturnFilesNew.aspx.cs"
    Inherits="Sugar_pgeCreateReturnFilesNew" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax1" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>GST Returns</title>
    <script type="text/javascript" src="../JS/DateValidation.js">
    </script>
    <script type="text/javascript" src="<%# ResolveUrl("~../Scripts/jquery-1.4.1.min.js") %>"></script>
</head>
<body style="background-color: White;">
    <script type="text/javascript" language="javascript">
        function Confirm() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Create CSV File?")) {
                confirm_value.value = "Yes";
                document.getElementById("<%= hdconfirm.ClientID %>").value = "Yes";
            }
            else {
                confirm_value.value = "No";
                document.getElementById("<%= hdconfirm.ClientID %>").value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }
    </script>
    <form id="form1" runat="server">
        <asp:HiddenField ID="hdconfirm" runat="server" />
        <div>
            <ajax1:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" EnablePageMethods="true">
            </ajax1:ToolkitScriptManager>
            <table border="0" cellpadding="5" cellspacing="5" style="margin: 0 auto;">
                <tr>
                    <td align="left">From Date:
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtFromDt" runat="server" Width="80px" CssClass="txt" Height="24px"
                            MaxLength="10" onkeyup="ValidateDate(this,event.keyCode)" onkeydown="return DateFormat(this,event.keyCode)"></asp:TextBox>
                        <asp:Image ID="imgcalender" runat="server" ImageUrl="~/Images/calendar_icon1.png"
                            Width="25px" Height="15px" />
                        <ajax1:CalendarExtender ID="calenderExtendertxtFromDt" runat="server" TargetControlID="txtFromDt"
                            PopupButtonID="imgcalender" Format="dd/MM/yyyy">
                        </ajax1:CalendarExtender>
                    </td>
                    <td align="left">To Date:
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtToDt" runat="server" Width="80px" CssClass="txt" Height="24px"
                            MaxLength="10" onkeyup="ValidateDate(this,event.keyCode)" onkeydown="return DateFormat(this,event.keyCode)"></asp:TextBox>
                        <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/calendar_icon1.png" Width="25px"
                            Height="15px" />
                        <ajax1:CalendarExtender ID="CalendarExtendertxtToDt" runat="server" TargetControlID="txtToDt"
                            PopupButtonID="Image1" Format="dd/MM/yyyy">
                        </ajax1:CalendarExtender>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="4" align="center">
                        <asp:Button Text="CREATE B2B FILE" runat="server" CssClass="btnHelp" ID="btnCreateb2b"
                            OnClick="btnCreateb2b_Click" />&nbsp;
                    <asp:Button Text="CREATE B2CL FILE" runat="server" CssClass="btnHelp" ID="btnCreateb2cl"
                        OnClick="btnCreateb2cl_Click" />
                        &nbsp;
                    <asp:Button Text="CREATE B2CS FILE" runat="server" CssClass="btnHelp" ID="btnCreateb2cs"
                        OnClick="btnCreateb2cs_Click" />
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        <asp:Button ID="btnCreatePurchaseBillSummary" Text="PURCHASE BILL SUMMARY" runat="server"
                            OnClick="btnCreatePurchaseBillSummary_Click" />
                    </td>
                    <td colspan="1">
                        <asp:Button ID="btnCreateSaleBillSummary" Text="SALE BILL SUMMARY" runat="server"
                            OnClick="btnCreateSaleBillSummary_Click" />
                    </td>
                    <td colspan="1">
                        <asp:Button ID="btlCreateRetailSaleSummary" Text="RETAIL SALE BILL SUMMARY" runat="server"
                            OnClick="btlCreateRetailSaleSummary_Click" />
                    </td>
                    <td colspan="1">
                        <asp:Button ID="btnFrieghtSummary" Text="FRIEGHT SUMMARY" runat="server" OnClick="btnFrieghtSummary_Click" />
                    </td>
                    <td colspan="1">
                        <asp:Button ID="btnDebitNoteSummary" Text="DEBIT NOTE SUMMARY" runat="server" OnClick="btnDebitNoteSummary_Click" />
                    </td>
                    <td colspan="1">
                        <asp:Button ID="btnCreditNoteSummary" Text="CREDIT NOTE SUMMARY" runat="server" OnClick="btnCreditNoteSummary_Click" />
                    </td>
                    <td colspan="1">
                        <asp:Button Text="E Way Bill" runat="server" ID="btnEwayBill" OnClick="btnEwayBill_Click" />
                    </td>
                    <td colspan="1">
                        <asp:Button Text="Empty E Way Bill" runat="server" ID="btnEmpty_E_Way_Bil" OnClick="btnEmpty_E_Way_Bil_Click" />
                    </td>
                    <td colspan="1">
                        <asp:Button Text="Sale BIll Checking" runat="server" ID="btnSale_Bill_Checking" OnClick="btnSale_Bill_Checking_Click" />
                    </td>
                    <td colspan="1">
                        <asp:Button Text="Summary" runat="server" ID="btnSummary" OnClick="btnSummary_Click" />
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        <asp:Button Text="Other Purchase" runat="server" ID="btnOtherPur" OnClick="btnOtherPur_Click" />
                    </td>
                    <td colspan="1">
                        <asp:Button Text="Service Bill" runat="server" ID="btnServiceBill" OnClick="btnServiceBill_Click" />
                    </td>
                    <td colspan="2">Sale TCS
                    <asp:DropDownList runat="server" ID="drpSaleTCS" OnSelectedIndexChanged="drpSaleTCS_SelectedIndexChanged">
                        <asp:ListItem Text="All" Value="All" Selected="True" />
                        <asp:ListItem Text="Sale Bill" Value="SB" />
                        <asp:ListItem Text="Sale Bill Corporate" Value="SC" />
                        <asp:ListItem Text="Sale Bill Non Corporate" Value="NC" />
                        <asp:ListItem Text="Sale Return Sale" Value="RS" />
                        <asp:ListItem Text="Retail Sale" Value="RR" />
                        <asp:ListItem Text="Commission Bill" Value="LV" />
                        <asp:ListItem Text="Cold Storage Sale" Value="CB" />
                        <asp:ListItem Text="Rent Bill" Value="RB" />
                    </asp:DropDownList>
                        <asp:Button Text="Sale TCS" runat="server" ID="btnSaleTCS" OnClick="btnSaleTCS_Click" OnClientClick="Confirm();" />
                          <asp:Button Text="Sale TDS" runat="server" ID="btnSaleTDS" OnClick="btnSaleTDS_Click" OnClientClick="Confirm();" />
                    </td>
                    <td colspan="2">Purchase TCS
                    <asp:DropDownList runat="server" ID="drppurchasrtcs" OnSelectedIndexChanged="drppurchasrtcs_SelectedIndexChanged">
                        <asp:ListItem Text="All" Value="All" Selected="False" />
                        <asp:ListItem Text="Purchase Bill" Value="PS" />
                        <asp:ListItem Text="Retail Purchase" Value="RP" />
                    </asp:DropDownList>
                        <asp:Button Text="Purchase TCS" runat="server" ID="btnPurchaseTCS" OnClick="btnPurchaseTCS_Click"
                            OnClientClick="Confirm();" />
                        <asp:Button Text="Purchase TDS" runat="server" ID="btnPurchaseTDS" OnClick="btnPurchaseTDS_Click"
                            OnClientClick="Confirm();" />
                    </td>
                    <td colspan="1">
                        <asp:Button Text="GSTR2" runat="server" ID="Button1" OnClick="btnGSTR2_Click" Visible="false" />
                    </td>
                    <td colspan="1">
                        <asp:Button Text="HSN Wise Sale" runat="server" ID="btnhsnsale" OnClick="btnhsnsale_Click"
                            OnClientClick="Confirm();" />
                    </td>
                    <td colspan="1">
                        <asp:Button Text="Return Sale" runat="server" ID="btnReturnSale" OnClick="btnReturnSale_Click" />
                    </td>
                    <td colspan="1">
                        <asp:Button Text="Return Purchase" runat="server" ID="btnpurchaseReturn" OnClick="btnpurchaseReturn_Click" />
                    </td>

                </tr>
                <tr>
                    <td colspan="2">Gst Rate
                    <asp:DropDownList runat="server" ID="drpGstRate" Width="100px" CssClass="ddl" AutoPostBack="true"
                        TabIndex="1" OnSelectedIndexChanged="drpGstRate_SelectedIndexChanged">
                    </asp:DropDownList>
                        <asp:Button Text="Gst Rate wise Sale" runat="server" ID="btnGstRate" OnClick="btnGstRate_Click" />
                    </td>

                    <td>
                        <asp:Button Text="Show Entry no" runat="server" ID="btnShowentryno" OnClick="btnShowentryno_Click" />
                    </td>

                    <td>
                        <asp:DropDownList runat="server" ID="drpdebitcreditnote" Width="100px" CssClass="ddl">
                            <asp:ListItem Text="All" Value="All" Selected="False" />
                            <asp:ListItem Text="Debit note to Customer" Value="DN" />
                            <asp:ListItem Text="Credit note to Customer" Value="CN" />
                            <asp:ListItem Text="Debit note to Supplier" Value="DS" />
                            <asp:ListItem Text="Customer note to Supplier" Value="CS" />

                        </asp:DropDownList>
                        <asp:Button Text="Debit Credit Note" runat="server" ID="btnDebitCreditNote" OnClick="btnDebitCreditNote_Click" />
                    </td>
                    <td>
                        <asp:Button Text="Generate RCM No to MEMO Advance" runat="server" ID="btngeneratememoadvance" OnClick="btngeneratememoadvance_Click" />
                        <asp:Button Text="Generate RCM Number" runat="server" ID="btngenerateRCMnum" OnClick="btngenerateRCMnum_Click" Visible="false" />

                    </td>
                    <td>
                        <asp:Button ID="btnClodstorageInword" Text="ColdStorage Outword SUMMARY" runat="server"
                            OnClick="btnClodstorageInword_Click" /></td>


                </tr>
            </table>
            <br />
            <asp:Panel runat="server" ID="pnlSale" BorderColor="Blue" Style="margin: 0 auto;"
                Width="100%">
                <br />
                <h3>
                    <asp:Label Text="" ID="lblSummary" runat="server" /></h3>
                <asp:Button Text="EXPORT TO EXCEL" ID="btnExportToexcel" OnClick="btnExportToexcel_Click"
                    runat="server" />
                <asp:GridView runat="server" ID="grdAll" AutoGenerateColumns="true" GridLines="Both"
                    HeaderStyle-Font-Bold="true" RowStyle-Height="30px" ShowFooter="true">
                    <%--<Columns>
                    <asp:BoundField DataField="SR_No" HeaderText="SR_No" ItemStyle-HorizontalAlign="Center"
                        ItemStyle-Width="30px" />
                    <asp:BoundField DataField="Invoice_No" HeaderText="Invoice No" ItemStyle-HorizontalAlign="Center"
                        ItemStyle-Width="80px" />
                    <asp:BoundField DataField="PartyGSTNo" HeaderText="GSTIN/UIN of Recipient" ItemStyle-HorizontalAlign="Center"
                        ItemStyle-Width="140px" />
                    <asp:BoundField DataField="PartyStateCode" HeaderText="State Code" ItemStyle-HorizontalAlign="Center"
                        ItemStyle-Width="40px" />
                    <asp:BoundField DataField="Invoice_Date" HeaderText="Invoice Date" ItemStyle-HorizontalAlign="Center"
                        ItemStyle-Width="100px" />
                    <asp:BoundField DataField="Vehicle_No" HeaderText="Vehicle No" ItemStyle-HorizontalAlign="Center"
                        ItemStyle-Width="140px" />
                    <asp:BoundField DataField="Quintal" HeaderText="Quintal" ItemStyle-HorizontalAlign="Right"
                        ItemStyle-Width="80px" />
                    <asp:BoundField DataField="Rate" HeaderText="Rate" ItemStyle-HorizontalAlign="Right"
                        ItemStyle-Width="100px" />
                    <asp:BoundField DataField="TaxableAmount" HeaderText="Taxable Amount" ItemStyle-HorizontalAlign="Right"
                        ItemStyle-Width="120px" />
                    <asp:BoundField DataField="CGST" HeaderText="CGST" ItemStyle-HorizontalAlign="Right"
                        ItemStyle-Width="120px" />
                    <asp:BoundField DataField="SGST" HeaderText="SGST" ItemStyle-HorizontalAlign="Right"
                        ItemStyle-Width="120px" />
                    <asp:BoundField DataField="IGST" HeaderText="IGST" ItemStyle-HorizontalAlign="Right"
                        ItemStyle-Width="120px" />
                    <asp:BoundField DataField="Payable_Amount" HeaderText="Final Amount" ItemStyle-HorizontalAlign="Right"
                        ItemStyle-Width="120px" />
                </Columns>--%>
                    <FooterStyle BackColor="Yellow" Font-Bold="true" />
                </asp:GridView>
            </asp:Panel>
            <%--<asp:Panel runat="server" ID="pnlPurchaseSummary" BorderColor="Blue" Style="margin: 0 auto;"
            Width="100%">
            <br />
            <h3>
                Purchase Summary</h3>
            <asp:Button Text="EXPORT TO EXCEL" ID="btnPSExport" OnClick="btnPSExport_Click" runat="server" />
            <asp:GridView runat="server" ID="grdPurchaseSummary" AutoGenerateColumns="false"
                GridLines="Both" HeaderStyle-Font-Bold="true" RowStyle-Height="30px" ShowFooter="true">
                <Columns>
                    <asp:BoundField DataField="SR_No" HeaderText="SR_No" ItemStyle-HorizontalAlign="Center"
                        ItemStyle-Width="30px" />
                    <asp:BoundField DataField="OurNo" HeaderText="Our No" ItemStyle-HorizontalAlign="Center"
                        ItemStyle-Width="80px" />
                    <asp:BoundField DataField="MillInvoiceNo" HeaderText="Mill Invoice No" ItemStyle-HorizontalAlign="Center"
                        ItemStyle-Width="80px" />
                    <asp:BoundField DataField="FromGSTNo" HeaderText="GSTIN" ItemStyle-HorizontalAlign="Center"
                        ItemStyle-Width="140px" />
                    <asp:BoundField DataField="FromStateCode" HeaderText="State Code" ItemStyle-HorizontalAlign="Center"
                        ItemStyle-Width="40px" />
                    <asp:BoundField DataField="Date" HeaderText="Invoice Date" ItemStyle-HorizontalAlign="Center"
                        ItemStyle-Width="100px" />
                    <asp:BoundField DataField="Vehicle_No" HeaderText="Vehicle No" ItemStyle-HorizontalAlign="Center"
                        ItemStyle-Width="140px" />
                    <asp:BoundField DataField="Quintal" HeaderText="Quintal" ItemStyle-HorizontalAlign="Right"
                        ItemStyle-Width="80px" />
                    <asp:BoundField DataField="Rate" HeaderText="Rate" ItemStyle-HorizontalAlign="Right"
                        ItemStyle-Width="100px" />
                    <asp:BoundField DataField="TaxableAmount" HeaderText="Taxable Amount" ItemStyle-HorizontalAlign="Right"
                        ItemStyle-Width="120px" />
                    <asp:BoundField DataField="CGST" HeaderText="CGST" ItemStyle-HorizontalAlign="Right"
                        ItemStyle-Width="120px" />
                    <asp:BoundField DataField="SGST" HeaderText="SGST" ItemStyle-HorizontalAlign="Right"
                        ItemStyle-Width="120px" />
                    <asp:BoundField DataField="IGST" HeaderText="IGST" ItemStyle-HorizontalAlign="Right"
                        ItemStyle-Width="120px" />
                    <asp:BoundField DataField="Payable_Amount" HeaderText="Final Amount" ItemStyle-HorizontalAlign="Right"
                        ItemStyle-Width="120px" />
                </Columns>
                <FooterStyle BackColor="Yellow" Font-Bold="true" />
            </asp:GridView>
        </asp:Panel>--%>
        </div>
    </form>
</body>
</html>
