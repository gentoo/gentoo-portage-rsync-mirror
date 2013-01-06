# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gtkdiskfree/gtkdiskfree-2.0.1.ebuild,v 1.6 2012/07/26 20:48:25 xmw Exp $

EAPI=4

inherit autotools

DESCRIPTION="Graphical tool to show free disk space"
HOMEPAGE="https://gitorious.org/gtkdiskfree"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE="gtk3 nls"

RDEPEND="gtk3? ( x11-libs/gtk+:3 )
	!gtk3? ( x11-libs/gtk+:3 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${PN}-master

src_prepare() {
	sed -e '/^CFLAGS=/s:=" -Wall -O2 :+=" :' \
		-i configure.in || die
	eautoreconf
}

src_configure() {
	local my_econf="--with-gtk2"
	use gtk3 && my_econf="--without-gtk2"
	econf $(use_enable nls) \
		${my_econf}
}
