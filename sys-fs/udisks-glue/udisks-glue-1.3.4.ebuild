# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/udisks-glue/udisks-glue-1.3.4.ebuild,v 1.5 2012/06/20 08:26:15 jdhore Exp $

EAPI=4
inherit autotools

DESCRIPTION="A tool to associate udisks events to user-defined actions"
HOMEPAGE="http://github.com/fernandotcl/udisks-glue"
SRC_URI="http://github.com/fernandotcl/udisks-glue/tarball/release-${PV} -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

COMMON_DEPEND=">=dev-libs/dbus-glib-0.92
	>=dev-libs/glib-2
	dev-libs/confuse"
RDEPEND="${COMMON_DEPEND}
	sys-fs/udisks:0"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig"

DOCS=( ChangeLog README )

src_unpack() {
	unpack ${A}
	mv *-${PN}-* "${S}"
}

src_prepare() {
	eautoreconf
}
