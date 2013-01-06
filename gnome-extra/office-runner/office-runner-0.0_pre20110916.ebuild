# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/office-runner/office-runner-0.0_pre20110916.ebuild,v 1.2 2012/05/05 06:25:19 jdhore Exp $

EAPI="4"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Lighthearted tool to temporarily inhibit GNOME's suspend on lid close behavior"
HOMEPAGE="http://www.gnome.org/ http://www.hadess.net/search/label/office-runner"
# No packaged upstream release yet
SRC_URI="mirror://gentoo/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/glib:2
	>=gnome-base/gnome-settings-daemon-3.0
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40.0
	virtual/pkgconfig
	sys-devel/gettext"

pkg_postinst() {
	gnome2_pkg_postinst

	elog "Note: ${PN} inhibits suspend on lid close only for 10 minutes"
}
