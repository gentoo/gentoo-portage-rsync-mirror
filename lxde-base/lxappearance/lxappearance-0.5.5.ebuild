# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/lxappearance/lxappearance-0.5.5.ebuild,v 1.6 2014/03/08 13:14:24 maekke Exp $

EAPI=5

DESCRIPTION="LXDE GTK+ theme switcher"
HOMEPAGE="http://lxde.sourceforge.net"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~mips ppc x86 ~x86-interix ~amd64-linux ~arm-linux ~x86-linux"
IUSE="dbus"

RDEPEND="x11-libs/gtk+:2
	dbus? ( dev-libs/dbus-glib )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

src_configure() {
	econf \
		$(use_enable dbus)
}
