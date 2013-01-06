# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sparkleshare/sparkleshare-0.9.2.ebuild,v 1.1 2012/09/15 11:59:45 pacho Exp $

EAPI="4"
GCONF_DEBUG="no" # --enable-debug does not do anything
PYTHON_DEPEND="nautilus? 2"

inherit gnome2 mono multilib python

DESCRIPTION="Git-based collaboration and file sharing tool"
HOMEPAGE="http://www.sparkleshare.org"
SRC_URI="http://github.com/downloads/hbons/SparkleShare/${P}.tar.gz"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="nautilus" # ayatana

COMMON_DEPEND=">=dev-lang/mono-2.8
	>=dev-dotnet/glib-sharp-2.12.7
	>=dev-dotnet/gtk-sharp-2.12.10
	dev-dotnet/notify-sharp
	dev-dotnet/webkit-sharp
	nautilus? ( || (
		(
			>=dev-python/nautilus-python-1.1-r1
			>=gnome-base/nautilus-3 )
		(
			<dev-python/nautilus-python-1.1
			=gnome-base/nautilus-2* )
	) )
"
RDEPEND="${COMMON_DEPEND}
	>=dev-vcs/git-1.7.3
	gnome-base/gvfs
	net-misc/curl[ssl]
	net-misc/openssh
	nautilus? ( || (
		(
			dev-python/pygobject:3
			>=gnome-base/nautilus-3[introspection]
			x11-libs/gtk+:3[introspection] )
		(
			dev-python/pygobject:2
			dev-python/pygtk:2 )
	) )
"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
"

pkg_setup () {
	DOCS="NEWS"
	G2CONF="${G2CONF}
		--disable-appindicator
		$(use_enable nautilus nautilus-extension)"
	#	$(use_enable ayatana appindicator)
	# requires >=appindicator-sharp-0.0.7
	python_pkg_setup
}

src_compile() {
	# FIXME: parallel make fails
	MAKEOPTS="${MAKEOPTS} -j1" gnome2_src_compile
}

pkg_postinst() {
	gnome2_pkg_postinst
	use nautilus && python_mod_optimize /usr/$(get_libdir)/nautilus/extensions-2.0/python/
}

pkg_postrm() {
	gnome2_pkg_postrm
	use nautilus && python_mod_cleanup /usr/$(get_libdir)/nautilus/extensions-2.0/python/
}
