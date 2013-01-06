# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/fcitx/fcitx-3.6.4.ebuild,v 1.2 2012/05/03 19:24:26 jdhore Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="Free Chinese Input Toy for X. Another Chinese XIM Input Method"
HOMEPAGE="http://www.fcitx.org/"
SRC_URI="http://fcitx.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dbus"

RDEPEND="x11-libs/libX11
	x11-libs/libXpm
	x11-libs/libXrender
	x11-libs/libXt
	x11-libs/libXtst
	x11-libs/libXext
	x11-libs/libXft
	dbus? ( >=sys-apps/dbus-0.2 )"
DEPEND="${RDEPEND}
	x11-proto/xproto
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-3.6.3-asneeded.patch
	eautoreconf
}

src_configure() {
	# --disable-xft doesn't work
	# econf $(use_enable xft) || die
	econf $(use_enable dbus) || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog README THANKS TODO || die

	rm -rf "${D}"/usr/share/fcitx/doc/ || die
	dodoc doc/pinyin.txt doc/cjkvinput.txt || die
	dohtml doc/wb_fh.htm || die
}

pkg_postinst() {
	elog
	elog "You should export the following variables to use fcitx"
	elog " export XMODIFIERS=\"@im=fcitx\""
	elog " export XIM=fcitx"
	elog " export XIM_PROGRAM=fcitx"
	elog
	elog "If you want to use WuBi ,ErBi or something else."
	elog " mkdir -p ~/.fcitx"
	elog " cp /usr/share/fcitx/data/wbx.mb ~/.fcitx"
	elog " cp /usr/share/fcitx/data/erbi.mb ~/.fcitx"
	elog " cp /usr/share/fcitx/data/tables.conf ~/.fcitx"
	elog
}
