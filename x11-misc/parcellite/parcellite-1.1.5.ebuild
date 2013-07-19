# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/parcellite/parcellite-1.1.5.ebuild,v 1.1 2013/07/19 12:50:42 jer Exp $

EAPI=4
inherit fdo-mime

MY_P=${PN}-${PV/_}

DESCRIPTION="A lightweight GTK+ based clipboard manager."
HOMEPAGE="http://parcellite.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

PL_LINGUAS=( ca cs da de es fr hu it ja nb pl pl_PL pt_BR ro ru sv tr zh_CN )
IUSE+=" ${PL_LINGUAS[@]/#/linguas_}"

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
	sed -i data/${PN}.desktop.in -e 's:Application;::g' || die
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
