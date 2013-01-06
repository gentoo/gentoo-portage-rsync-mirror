# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/fcitx/fcitx-4.2.1.ebuild,v 1.9 2012/08/19 08:47:40 scarabeus Exp $

EAPI="3"

inherit multilib cmake-utils eutils

DESCRIPTION="Free Chinese Input Toy for X. Another Chinese XIM Input Method"
HOMEPAGE="http://www.fcitx.org/"
SRC_URI="
	http://fcitx.googlecode.com/files/${P}.tar.xz
	http://fcitx.googlecode.com/files/pinyin.tar.gz
	http://fcitx.googlecode.com/files/table.tar.gz
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE="cairo dbus debug gtk gtk3 opencc pango qt4 table"

RDEPEND="x11-libs/libX11
	x11-libs/libXrender
	media-libs/fontconfig
	pango? ( x11-libs/pango )
	opencc? ( app-i18n/opencc )
	gtk? ( x11-libs/gtk+:2 )
	gtk3? ( x11-libs/gtk+:3 )
	cairo? ( x11-libs/cairo[X] )
	dbus? ( sys-apps/dbus )"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	dev-util/intltool
	virtual/pkgconfig
	x11-proto/xproto"

update_gtk_immodules() {
	local GTK2_CONFDIR="/etc/gtk-2.0"
	# bug #366889
	if has_version '>=x11-libs/gtk+-2.22.1-r1:2' || has_multilib_profile ; then
		GTK2_CONFDIR="${GTK2_CONFDIR}/$(get_abi_CHOST)"
	fi
	mkdir -p "${EPREFIX}${GTK2_CONFDIR}"

	if [ -x "${EPREFIX}/usr/bin/gtk-query-immodules-2.0" ] ; then
		"${EPREFIX}/usr/bin/gtk-query-immodules-2.0" > "${EPREFIX}${GTK2_CONFDIR}/gtk.immodules"
	fi
}

update_gtk3_immodules() {
	if [ -x "${EPREFIX}/usr/bin/gtk-query-immodules-3.0" ] ; then
		"${EPREFIX}/usr/bin/gtk-query-immodules-3.0" --update-cache
	fi
}

src_unpack() {
	unpack ${P}.tar.xz
	cp "${DISTDIR}"/pinyin.tar.gz "${S}"/data/
	cp "${DISTDIR}/table.tar.gz" "${S}/data/table"
}

src_configure() {
	local mycmakeargs="
		-DLIB_INSTALL_DIR=/usr/$(get_libdir)
		$(cmake-utils_use_enable cairo)
		$(cmake-utils_use_enable dbus)
		$(cmake-utils_use_enable debug)
		$(cmake-utils_use_enable gtk GTK2_IM_MODULE)
		$(cmake-utils_use_enable gtk3 GTK3_IM_MODULE)
		$(cmake-utils_use_enable qt4 QT_IM_MODULE)
		$(cmake-utils_use_enable opencc)
		$(cmake-utils_use_enable pango)
		$(cmake-utils_use_enable table)"
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	dodoc AUTHORS ChangeLog README THANKS TODO || die

	rm -rf "${ED}"/usr/share/fcitx/doc/ || die
	dodoc doc/pinyin.txt doc/cjkvinput.txt || die
	dohtml doc/wb_fh.htm || die
}

pkg_postinst() {
	use gtk && update_gtk_immodules
	use gtk3 && update_gtk3_immodules
	elog
	elog "You should export the following variables to use fcitx"
	elog " export XMODIFIERS=\"@im=fcitx\""
	elog " export XIM=fcitx"
	elog " export XIM_PROGRAM=fcitx"
	elog
}

pkg_postrm() {
	use gtk && update_gtk_immodules
	use gtk3 && update_gtk3_immodules
}
