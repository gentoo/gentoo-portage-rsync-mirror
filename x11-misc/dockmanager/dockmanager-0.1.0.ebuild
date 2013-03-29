# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/dockmanager/dockmanager-0.1.0.ebuild,v 1.4 2013/03/29 21:15:23 angelos Exp $

EAPI=3
PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"
inherit gnome2 python vala

DESCRIPTION="dock-independent helper scripts"
HOMEPAGE="https://launchpad.net/dockmanager"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="dev-libs/dbus-glib
	dev-libs/glib:2
	x11-libs/gtk+:2
	x11-libs/libdesktop-agnostic"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig"

pkg_setup() {
	DOCS="AUTHORS"
	python_set_active_version 2
}

src_prepare() {
	rm -f {scripts,metadata}/pidgin_control.* || die
	sed -i -e "/pidgin_control/d" {scripts,metadata}/Makefile.* || die
}

src_configure() {
	gnome2_src_configure \
		$(use_enable debug) \
		$(use_enable !debug release)
}
