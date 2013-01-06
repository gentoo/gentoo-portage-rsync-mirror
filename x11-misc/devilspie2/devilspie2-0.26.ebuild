# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/devilspie2/devilspie2-0.26.ebuild,v 1.1 2012/11/27 23:51:43 hasufell Exp $

EAPI=5

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Devilspie like window matching utility, using LUA for scripting"
HOMEPAGE="http://devilspie2.gusnan.se"
SRC_URI="http://devilspie2.gusnan.se/download/${PN}_${PV}-src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=dev-libs/glib-2.32.4:2
	>=dev-lang/lua-5.1.5
	>=x11-libs/gtk+-3.4.4:3
	>=x11-libs/libwnck-3.4.4:3
	x11-libs/libX11"
DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig
	x11-proto/xproto"

src_prepare() {
	epatch "${FILESDIR}"/${P}-{anti-debian,cflags}.patch

	use debug && append-cflags -D_DEBUG
}

src_compile() {
	emake CC=$(tc-getCC) PREFIX="/usr"
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" install

	dodoc AUTHORS ChangeLog README README.translators TODO VERSION
	doman devilspie2.1
}

pkg_postinst() {
	elog "Default folder for scripts is ~/.config/devilspie2/"
}
