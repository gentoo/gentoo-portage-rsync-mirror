# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/lxsession/lxsession-0.4.9.2.ebuild,v 1.1 2013/10/07 18:06:04 hwoarang Exp $

EAPI=5

VALA_MIN_API_VERSION="0.14"
VALA_MAX_API_VERSION="0.20"

inherit vala

DESCRIPTION="LXDE session manager (lite version)"
HOMEPAGE="http://lxde.sf.net/"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~ppc ~x86 ~arm-linux ~x86-linux"
SLOT="0"
# upower USE flag is enabled by default in the desktop profile
IUSE="nls upower"

COMMON_DEPEND="dev-libs/glib:2
	lxde-base/lxde-common
	x11-libs/gtk+:2
	x11-libs/libX11
	sys-apps/dbus"
RDEPEND="${COMMON_DEPEND}
	!lxde-base/lxsession-edit
	upower? ( sys-power/upower )"
DEPEND="${COMMON_DEPEND}
	$(vala_depend)
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig
	x11-proto/xproto"

DOCS="AUTHORS ChangeLog README"

src_configure() {
	# dbus is used for restart/shutdown (CK, logind?), and suspend/hibernate (UPower)
	econf \
		$(use_enable nls)
}
