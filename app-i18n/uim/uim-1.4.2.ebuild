# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/uim/uim-1.4.2.ebuild,v 1.17 2011/03/27 11:38:50 nirbheek Exp $

EAPI=1
inherit eutils multilib elisp-common flag-o-matic

DESCRIPTION="Simple, secure and flexible input method library"
HOMEPAGE="http://code.google.com/p/uim/"
SRC_URI="http://uim.googlecode.com/files/${P}.tar.bz2"

LICENSE="BSD GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 hppa ppc ppc64 x86"
IUSE="anthy canna eb emacs gnome gtk libedit m17n-lib ncurses nls prime X linguas_zh_CN linguas_ja linguas_ko"

RDEPEND="X? ( x11-libs/libX11
		x11-libs/libXft
		x11-libs/libXt
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libXext
		x11-libs/libXrender )
	anthy? ( || ( app-i18n/anthy app-i18n/anthy-ss ) )
	canna? ( app-i18n/canna )
	eb? ( dev-libs/eb )
	emacs? ( virtual/emacs )
	gnome? ( >=gnome-base/gnome-panel-2.14 )
	gtk? ( >=x11-libs/gtk+-2.4:2 )
	libedit? ( dev-libs/libedit )
	m17n-lib? ( >=dev-libs/m17n-lib-1.3.1 )
	ncurses? ( sys-libs/ncurses )
	nls? ( virtual/libintl )
	prime? ( app-i18n/prime )
	!app-i18n/uim-svn
	!<app-i18n/prime-0.9.4"

DEPEND="${RDEPEND}
	X? ( x11-proto/xextproto
		x11-proto/xproto )"

RDEPEND="${RDEPEND}
	X? (
		media-fonts/font-sony-misc
		linguas_zh_CN? ( media-fonts/font-isas-misc )
		linguas_ja? ( media-fonts/font-jis-misc )
		linguas_ko? ( media-fonts/font-daewoo-misc )
	)"
#		linguas_zh_TW? ( media-fonts/taipeifonts )

SITEFILE=50${PN}-gentoo.el

pkg_setup() {
	# An arch specific config directory is used on multilib systems
	has_multilib_profile && GTK2_CONFDIR="/etc/gtk-2.0/${CHOST}"
	GTK2_CONFDIR=${GTK2_CONFDIR:=/etc/gtk-2.0/}
}

src_compile() {
	local myconf

	if use gtk && (use anthy || use canna); then
		myconf="${myconf} --enable-dict"
	else
		myconf="${myconf} --disable-dict"
	fi

	if use gtk; then
		myconf="${myconf} --enable-pref"
	else
		myconf="${myconf} --disable-pref"
	fi

	econf $(use_with X x) \
		$(use_with anthy) \
		$(use_with canna) \
		$(use_with eb) \
		$(use_enable emacs) \
		$(use_with emacs lispdir "${SITELISP}") \
		$(use_enable gnome gnome-applet) \
		$(use_with gtk gtk2) \
		$(use_with libedit) \
		--disable-kde-applet \
		$(use_with m17n-lib m17nlib) \
		$(use_enable ncurses fep) \
		$(use_enable nls) \
		--without-qt \
		--without-qt-immodule \
		${myconf}
	emake -j1 || die "emake failed"

	if use emacs; then
		cd emacs
		elisp-compile *.el || die "elisp-compile failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog* NEWS README RELNOTE
	if use emacs; then
		elisp-install uim-el emacs/*.elc || die "elisp-install failed"
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" uim-el \
			|| die "elisp-site-file-install failed"
	fi
}

pkg_postinst() {
	elog
	elog "To use uim-skk you should emerge app-i18n/skk-jisyo."
	elog

	elog
	elog "New input method switcher has been introduced. You need to set"
	elog
	elog "% GTK_IM_MODULE=uim ; export GTK_IM_MODULE"
	elog "% XMODIFIERS=@im=uim ; export XMODIFIERS"
	elog
	elog "If you would like to use uim-anthy as default input method, put"
	elog "(define default-im-name 'anthy)"
	elog "to your ~/.uim."
	elog
	elog "All input methods can be found by running uim-im-switcher-gtk"
	elog
	elog "If you upgrade from a version of uim older than 1.4.0,"
	elog "you should run revdep-rebuild."

	use gtk && gtk-query-immodules-2.0 > "${ROOT}/${GTK2_CONFDIR}/gtk.immodules"
	if use emacs; then
		elisp-site-regen
		echo
		elog "uim is autoloaded with Emacs with a minimal set of features:"
		elog "There is no keybinding defined to call it directly, so please"
		elog "create one yourself and choose an input method."
		elog "Integration with LEIM is not done with this ebuild, please have"
		elog "a look at the documentation how to achieve this."
	fi
}

pkg_postrm() {
	use gtk && gtk-query-immodules-2.0 > "${ROOT}/${GTK2_CONFDIR}/gtk.immodules"
	use emacs && elisp-site-regen
}
