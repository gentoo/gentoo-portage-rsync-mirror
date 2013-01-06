# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monodevelop/monodevelop-2.8.5.1.ebuild,v 1.5 2012/05/22 12:20:01 ago Exp $

EAPI=4
inherit fdo-mime gnome2-utils mono versionator

DESCRIPTION="Integrated Development Environment for .NET"
HOMEPAGE="http://www.monodevelop.com/"
SRC_URI="http://download.mono-project.com/sources/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+subversion +git"

RDEPEND=">=dev-lang/mono-2.6.1
	>=dev-dotnet/gconf-sharp-2.24.0
	>=dev-dotnet/glade-sharp-2.12.9
	>=dev-dotnet/gnome-sharp-2.24.0
	>=dev-dotnet/gnomevfs-sharp-2.24.0
	>=dev-dotnet/gtk-sharp-2.12.9
	>=dev-dotnet/mono-addins-0.6[gtk]
	>=dev-dotnet/xsp-2
	dev-util/ctags
	sys-apps/dbus[X]
	>=virtual/monodoc-2.0
	|| (
		www-client/firefox
		www-client/firefox-bin
		www-client/seamonkey
		)
	subversion? ( dev-vcs/subversion )
	!<dev-util/monodevelop-boo-$(get_version_component_range 1-2)
	!<dev-util/monodevelop-java-$(get_version_component_range 1-2)
	!<dev-util/monodevelop-database-$(get_version_component_range 1-2)
	!<dev-util/monodevelop-debugger-gdb-$(get_version_component_range 1-2)
	!<dev-util/monodevelop-debugger-mdb-$(get_version_component_range 1-2)
	!<dev-util/monodevelop-vala-$(get_version_component_range 1-2)"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext
	x11-misc/shared-mime-info"

MAKEOPTS="${MAKEOPTS} -j1"

src_configure() {
	econf \
		--disable-update-mimedb \
		--disable-update-desktopdb \
		--enable-monoextensions \
		--enable-gnomeplatform \
		$(use_enable subversion) \
		$(use_enable git)
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
	elog "These optional plugins currently exist:"
	elog " - dev-util/monodevelop-python"
	elog " - dev-util/monodevelop-java"
	elog " - dev-util/monodevelop-database"
	elog " - dev-util/monodevelop-debugger-gdb"
	elog " - dev-util/monodevelop-vala"
	elog "To enable their (self-explanatory) functionality, just emerge them."
	elog "Read more here:"
	elog "http://monodevelop.com/"
}

pkg_postrm() {
	gnome2_icon_cache_update
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
}
