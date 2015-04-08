# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim/scim-1.4.9-r1.ebuild,v 1.16 2012/06/21 14:22:36 naota Exp $

EAPI="2"
inherit autotools eutils flag-o-matic multilib

DESCRIPTION="Smart Common Input Method (SCIM) is an Input Method (IM) development platform"
HOMEPAGE="http://www.scim-im.org/"
SRC_URI="mirror://sourceforge/scim/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc ppc64 x86 ~x86-fbsd"
IUSE="doc"

RDEPEND="x11-libs/libX11
	dev-libs/glib:2
	x11-libs/gtk+:2
	>=dev-libs/atk-1
	>=x11-libs/pango-1
	!app-i18n/scim-cvs"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen
		>=app-text/docbook-xsl-stylesheets-1.73.1 )
	dev-lang/perl
	virtual/pkgconfig
	>=dev-util/intltool-0.33
	sys-devel/libtool"

pkg_setup() {
	# bug #366889
	if has_version '>=x11-libs/gtk+-2.22.1-r1:2' || has_multilib_profile ; then
		GTK2_CONFDIR="/etc/gtk-2.0/${CHOST}"
	fi
	GTK2_CONFDIR=${GTK2_CONFDIR:=/etc/gtk-2.0/}
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.4.7-syslibltdl.patch"
	# bug #283317
	epatch "${FILESDIR}/${PN}-fix-disappeared-status-icon.patch"
	# remove m4/intltool.me to update it #417563
	rm "${S}"/src/ltdl.{cpp,h} m4/intltool.m4 || die
	eautoreconf
}

src_configure() {
	local myconf
	# bug #83625
	filter-flags -fvisibility-inlines-hidden
	filter-flags -fvisibility=hidden

	# bug #191696
	## We cannot use "use_enable"
	#if ! use gtk ; then
	#	myconf="${myconf} --disable-panel-gtk"
	#	myconf="${myconf} --disable-setup-ui"
	#	myconf="${myconf} --disable-gtk2-immodule"
	#fi

	econf \
		$(use_with doc doxygen) \
		--enable-ld-version-script \
		${myconf} || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README AUTHORS ChangeLog docs/developers docs/scim.cfg
	use doc && dohtml -r docs/html/*
}

pkg_postinst() {
	elog
	elog "To use SCIM with both GTK2 and XIM, you should use the following"
	elog "in your user startup scripts such as .gnomerc or .xinitrc:"
	elog
	elog "LANG='your_language' scim -d"
	elog "export XMODIFIERS=@im=SCIM"
	elog "export GTK_IM_MODULE=\"scim\""
	elog "export QT_IM_MODULE=\"scim\""
	elog
	elog "where 'your_language' can be zh_CN, zh_TW, ja_JP.eucJP or any other"
	elog "UTF-8 locale such as en_US.UTF-8 or ja_JP.UTF-8"
	elog
	elog "To use Chinese input methods:"
	elog "	# emerge app-i18n/scim-tables app-i18n/scim-pinyin"
	elog "To use Korean input methods:"
	elog "	# emerge app-i18n/scim-hangul"
	elog "To use Japanese input methods:"
	elog "	# emerge app-i18n/scim-anthy"
	elog "To use various input methods (more than 30 languages):"
	elog "	# emerge app-i18n/scim-m17n"
	elog
	elog "Please modify ${EPREFIX}/etc/scim/global and add your UTF-8 locale to"
	elog "/SupportedUnicodeLocales entry."
	elog
	ewarn
	ewarn "If you upgraded from scim-1.2.x or scim-1.0.x, you should remerge all SCIM modules."
	ewarn

	[ -x /usr/bin/gtk-query-immodules-2.0 ] && gtk-query-immodules-2.0 > "${ROOT}/${GTK2_CONFDIR}/gtk.immodules"
}

pkg_postrm() {
	[ -x /usr/bin/gtk-query-immodules-2.0 ] && gtk-query-immodules-2.0 > "${ROOT}/${GTK2_CONFDIR}/gtk.immodules"
}
