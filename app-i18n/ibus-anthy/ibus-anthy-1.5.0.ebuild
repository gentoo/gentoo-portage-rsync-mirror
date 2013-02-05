# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ibus-anthy/ibus-anthy-1.5.0.ebuild,v 1.1 2013/02/05 11:33:29 yngwin Exp $

EAPI=5
PYTHON_DEPEND="2:2.5"
inherit eutils python

DESCRIPTION="Japanese input method Anthy IMEngine for IBus Framework"
HOMEPAGE="http://code.google.com/p/ibus/"
SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls"

RDEPEND=">=app-i18n/ibus-1.2.0.20100111
	app-i18n/anthy
	>=dev-python/pygtk-2.15.2
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	dev-lang/swig
	dev-util/intltool
	virtual/pkgconfig
	nls? ( >=sys-devel/gettext-0.16.1 )"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	>py-compile #397497
	sed -i -e "s/python/python2/" \
		engine/ibus-engine-anthy.in setup/ibus-setup-anthy.in || die
}

src_configure() {
	econf $(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install

	dodoc AUTHORS ChangeLog NEWS README

	find "${ED}" -name '*.la' -type f -delete || die
}

pkg_postinst() {
	elog
	elog "app-dicts/kasumi is not required but probably useful for you."
	elog
	elog "# emerge app-dicts/kasumi"
	elog

	python_mod_optimize /usr/share/${PN}
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}
}
