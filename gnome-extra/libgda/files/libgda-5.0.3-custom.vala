namespace Gda {
	public class DataProxy : GLib.Object, Gda.DataModel {
		[CCode (cname="gda_data_proxy_new")]
		public static GLib.Object @new (Gda.DataModel model);
	}
}
