# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/cups-pk-helper/cups-pk-helper-0.2.2.ebuild,v 1.12 2012/10/16 02:41:29 mattst88 Exp $

EAPI="4"

inherit eutils

DESCRIPTION="PolicyKit helper to configure cups with fine-grained privileges"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/cups-pk-helper"
SRC_URI="http://www.freedesktop.org/software/${PN}/releases/${P}.tar.xz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="alpha amd64 arm ~ppc ~ppc64 x86"
IUSE=""

# Require {glib,gdbus-codegen}-2.30.0 due to GDBus changes between 2.29.92
# and 2.30.0
COMMON_DEPEND=">=dev-libs/glib-2.30.0:2
	net-print/cups
	>=sys-auth/polkit-0.97"
RDEPEND="${COMMON_DEPEND}
	sys-apps/dbus"
DEPEND="${COMMON_DEPEND}
	app-arch/xz-utils
	>=dev-util/gdbus-codegen-2.30.0
	>=dev-util/intltool-0.40.6
	virtual/pkgconfig
	sys-devel/gettext"

src_prepare() {
	DOCS="AUTHORS HACKING NEWS README"

	# bug #428544, https://bugs.freedesktop.org/show_bug.cgi?id=52265
	epatch "${FILESDIR}/${PN}-0.2.2-cups-1.6.patch"

	# Regenerate dbus-codegen files to fix build with glib-2.30.x; bug #410773
	rm -v src/cph-iface-mechanism.{c,h} || die
}
