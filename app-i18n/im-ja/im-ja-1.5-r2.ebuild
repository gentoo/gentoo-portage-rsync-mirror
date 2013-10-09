# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/im-ja/im-ja-1.5-r2.ebuild,v 1.10 2013/10/09 02:04:16 naota Exp $

EAPI="3"
inherit autotools gnome2 gnome2-utils eutils multilib

DESCRIPTION="A Japanese input module for GTK2 and XIM"
HOMEPAGE="http://im-ja.sourceforge.net/"
SRC_URI="http://im-ja.sourceforge.net/${P}.tar.gz
	http://im-ja.sourceforge.net/old/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="gnome canna freewnn skk anthy"
# --enable-debug causes build failure with gtk+-2.4
#IUSE="${IUSE} debug"

RDEPEND=">=dev-libs/glib-2.4:2
	>=dev-libs/atk-1.6
	>=x11-libs/gtk+-2.4:2
	>=x11-libs/pango-1.2.1
	>=gnome-base/gconf-2.4:2
	>=gnome-base/libglade-2.4:2.0
	>=gnome-base/libgnomeui-2.4
	gnome? (
		|| (
			gnome-base/gnome-panel[bonobo]
			<gnome-base/gnome-panel-2.32
		)
	)
	freewnn? ( app-i18n/freewnn )
	canna? ( app-i18n/canna )
	skk? ( virtual/skkserv )
	anthy? ( app-i18n/anthy )"
DEPEND="${RDEPEND}
	dev-lang/perl
	dev-util/intltool
	dev-perl/URI
	virtual/pkgconfig"

DOCS="AUTHORS README ChangeLog TODO"

src_prepare() {
	epatch "${FILESDIR}/${P}-gentoo.patch" \
		"${FILESDIR}"/${P}-pofiles.patch
	sed -ie 's/AM_CONFIG_HEADER/AC_CONFIG_HEADERS/' configure.in || die
	eautoreconf
}

src_configure() {
	local myconf
	# You cannot use `use_enable ...` here. im-ja's configure script
	# doesn't distinguish --enable-canna from --disable-canna, so
	# --enable-canna stands for --disable-canna in the script ;-(
	use gnome || myconf="$myconf --disable-gnome"
	use canna || myconf="$myconf --disable-canna"
	use freewnn || myconf="$myconf --disable-wnn"
	use anthy || myconf="$myconf --disable-anthy"
	use skk || myconf="$myconf --disable-skk"
	#use debug && myconf="$myconf --enable-debug"

	# gnome2_src_compile automatically sets debug IUSE flag
	econf $myconf || die "econf im-ja failed"
}

src_install() {
	gnome2_src_install

	sed -e "s:@EPREFIX@:${EPREFIX}:" "${FILESDIR}/xinput-${PN}" > "${T}/${PN}.conf" || die
	insinto /etc/X11/xinit/xinput.d
	doins "${T}/${PN}.conf" || die
}

pkg_postinst() {
	gnome2_query_immodules_gtk2
	gnome2_pkg_postinst
	elog
	elog "This version of im-ja comes with experimental XIM support."
	elog "If you'd like to try it out, run im-ja-xim-server and set"
	elog "environment variable XMODIFIERS to @im=im-ja-xim-server"
	elog "e.g.)"
	elog "\t$ export XMODIFIERS=@im=im-ja-xim-server (sh)"
	elog "\t> setenv XMODIFIERS @im=im-ja-xim-server (csh)"
	elog
}

pkg_postrm() {
	gnome2_query_immodules_gtk2
	gnome2_pkg_postrm
}
