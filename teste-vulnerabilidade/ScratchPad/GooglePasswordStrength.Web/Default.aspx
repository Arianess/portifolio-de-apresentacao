<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GooglePasswordStrength.Web._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Google Password Strength</title>
    <style>
		.password
		{
			font-family:Arial;
			font-size:80%;
		}
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
		<table>
			<tr>
				<td><asp:TextBox ID="txtPassword" runat="server" /></td>
				<td><google:PasswordStrength ID="PS" TargetControlID="txtPassword" CssClass="password" runat="server" /> </td>
			</tr>
			
		</table>
    </div>
    </form>
</body>
</html>
