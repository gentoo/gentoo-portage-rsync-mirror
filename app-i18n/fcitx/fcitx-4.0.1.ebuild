# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/fcitx/fcitx-4.0.1.ebuild,v 1.5 2012/05/18 14:21:32 josejx Exp $

EAPI="3"

inherit eutils

DESCRIPTION="Free Chinese Input Toy for X. Another Chinese XIM Input Method"
HOMEPAGE="http://www.fcitx.org/"
SRC_URI="http://fcitx.googlecode.com/files/${P}_all.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="dbus pango"

RDEPEND="x11-libs/libX11
	x11-libs/libXrender
	x11-libs/cairo[X]
	media-libs/fontconfig
	pango? ( x11-libs/pango )
	dbus? ( >=sys-apps/dbus-0.2 )"
DEPEND="${RDEPEND}
	x11-proto/xproto
	virtual/pkgconfig"

src_prepare() {
	# fix a bug when compiling without pango
	epatch "${FILESDIR}/${P}-fix-pango.patch"
}

src_configure() {
	econf \
		$(use_enable dbus) \
		$(use_enable pango) || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog README THANKS TODO || die

	rm -rf "${ED}"/usr/share/fcitx/doc/ || die
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
