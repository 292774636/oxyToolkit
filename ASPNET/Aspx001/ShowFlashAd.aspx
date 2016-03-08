<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ShowFlashAd.aspx.cs" Inherits="ShowFlashAd" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server"> 
    <div> 
        <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0"; target=_blank>http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="<%=Pics_Width %>" height="<%=Swf_Height %>"> 
        <param name="allowscriptaccess" value="sameDomain"/> 
        <param name="movie" value="flash/loader.swf"/> 
        <param name="quality" value="high"/>/ 
        <param name="bgcolor" value="#F0F0F0"/> 
        <param name="menu" value="false"/> 
        <param name="wmode" value="opaque"/> 
        <param name="flashvars" value="Pics=<%=Pics %>&links=<%=Links %>&texts=<%=Texts %>&borderwidth=<%=Pics_Width %>&borderheight=<%=Pics_Height %>&textheight=<%=Texts_Height %>"/> 
        </object>                   
    </div> 
    </form> 
</body>
</html>
