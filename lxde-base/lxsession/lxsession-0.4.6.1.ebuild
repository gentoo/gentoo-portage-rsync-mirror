# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/lxsession/lxsession-0.4.6.1.ebuild,v 1.6 2012/06/05 01:03:43 xmw Exp $

EAPI="4"

DESCRIPTION="LXDE session manager (lite version)"
HOMEPAGE="http://lxde.sf.net/"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~alpha amd64 arm ppc x86"
SLOT="0"
IUSE="nls udev"

COMMON_DEPEND="dev-libs/glib:2
	x11-libs/gtk+:2
	>=lxde-base/lxde-common-0.5.0
	x11-libs/libX11
	udev? ( >=sys-apps/dbus-1.4.1 )"
RDEPEND="${COMMON_DEPEND}
	udev? ( >=sys-power/upower-0.9.5 )"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext
	x11-proto/xproto"

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable udev dbus) \
		$(use_enable nls) \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog README
}
