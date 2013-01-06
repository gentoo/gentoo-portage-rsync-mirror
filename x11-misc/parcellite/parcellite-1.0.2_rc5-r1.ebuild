# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/parcellite/parcellite-1.0.2_rc5-r1.ebuild,v 1.1 2012/09/28 15:50:45 jer Exp $

EAPI=4
inherit autotools eutils fdo-mime

MY_P=${PN}-${PV/_}

DESCRIPTION="A lightweight GTK+ based clipboard manager."
HOMEPAGE="http://parcellite.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

PL_LINGUAS="ca cs da de es fr hu it ja nb pl pl_PL pt_BR ro ru sv tr zh_CN"
for lingua in ${PL_LINGUAS}; do
	IUSE+=" linguas_${lingua}"
done

RDEPEND=">=dev-libs/glib-2.14
	>=x11-libs/gtk+-2.10:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? (
		dev-util/intltool
		sys-devel/gettext
		)"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-glib-2.31.patch
	eautoreconf
}

src_configure() {
	econf $(use_enable nls)
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
