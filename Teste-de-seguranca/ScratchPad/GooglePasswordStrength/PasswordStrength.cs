using System;
using System.Collections.Generic;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections;

[assembly: WebResource("GooglePasswordStrength.PasswordStrength.js", "text/javascript")]
[assembly: WebResource("GooglePasswordStrength.PasswordStrength.css", "text/css")]

namespace GooglePasswordStrength
{
    public class PasswordStrength : WebControl
    {
        #region Declarations

        private string _targetControlId = string.Empty;
        private Control _ctl;

        #endregion Declarations

        #region Lifecycle

        protected override void OnPreRender(EventArgs e)
        {
            string scriptUrl = ClientScriptProxy.Current.GetWebResourceUrl(this, GetType(), "GooglePasswordStrength.PasswordStrength.js");
            ClientScriptProxy.Current.RegisterClientScriptInclude(this, GetType(), "GPasswordStrength", scriptUrl);

            HtmlLink styleLink = new HtmlLink();
            styleLink.Href = ClientScriptProxy.Current.GetWebResourceUrl(this, GetType(), "GooglePasswordStrength.PasswordStrength.css");
            styleLink.Attributes.Add("rel", "stylesheet");
            styleLink.Attributes.Add("type", "text/css");
            Page.Header.Controls.Add(styleLink);

            string startScript = string.Format("var {0}_jsControl = new PasswordStrengthControl('{0}');{0}_jsControl.initialize('{1}');", ID, TargetControl.ClientID);
            ClientScriptProxy.Current.RegisterStartupScript(this, GetType(), "PasswordStrengthControl_initialize", startScript, true);

            base.OnPreRender(e);
        }

        protected override void Render(HtmlTextWriter writer)
        {
            base.RenderBeginTag(writer);

            writer.Write("<table cellspacing='0' cellpadding='0'>");

            writer.RenderBeginTag(HtmlTextWriterTag.Tr);
            writer.Write(string.Format("<td>Password Strength:</td><td id='{0}_text'></td>", ID));
            writer.RenderEndTag();

            writer.Write("<tr>");
            writer.Write("<td colspan='2'><table cellspacing='0' cellpadding='0'><tr style='height:4px'>");
            writer.Write(string.Format("<td id='{0}_leftBar' class='leftBar0'></td><td id='{0}_rightBar' class='rightBar0'></td>", ID));
            writer.Write("</tr></table></td>");
            writer.Write("</tr>");

            writer.Write("</table>");

            base.RenderEndTag(writer);
        }


        #endregion Lifecycle

        #region General

        #endregion General

        #region Methods

        #endregion Methods

        private Control FindControl(Control control, string id)
        {
            if (_ctl != null) return _ctl;
            IEnumerator iEnum = control.Controls.GetEnumerator();
            iEnum.Reset();
            while (iEnum.MoveNext())
            {
                if (_ctl != null) break;
                if (((Control)iEnum.Current).ID == id)
                {
                    _ctl = ((Control)iEnum.Current);
                    break;
                }
                FindControl(((Control)iEnum.Current), id);
            }
            return _ctl;
        }


        #region Properties

        public string TargetControlID
        {
            get { return _targetControlId; }
            set { _targetControlId = value; }
        }

        internal TextBox TargetControl
        {
            get
            {
                Control ctl = FindControl(Page, TargetControlID);
                if (ctl is TextBox)
                    return (TextBox)ctl;
                return null;
            }
        }


        protected override HtmlTextWriterTag TagKey
        {
            get
            {
                return HtmlTextWriterTag.Div;
            }
        }

        #endregion Properties

        #region UI Events

        #endregion UI Events

    }
}
