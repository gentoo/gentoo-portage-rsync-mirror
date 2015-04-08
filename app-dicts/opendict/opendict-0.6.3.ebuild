# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/opendict/opendict-0.6.3.ebuild,v 1.10 2014/08/10 02:33:07 patrick Exp $

EAPI=3
PYTHON_DEPEND=2

inherit eutils gnome2 python

DESCRIPTION="OpenDict is a free cross-platform dictionary program"
HOMEPAGE="http://opendict.sourceforge.net/"
SRC_URI="http://opendict.idiles.com/files/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="dev-python/wxpython:2.8"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-pyxml.patch

	sed -e "s:), '..')):), '../../../../..', 'share', 'opendict')):g" \
		-i "${S}/lib/info.py"
}

src_configure() {
	# override gnome2_src_configure
	default
}

src_compile() {
	# evil makefile
	:
}

src_install() {
	# makefile is broken, do it manually

	dodir /usr/share/${PN}/dictionaries/plugins # global dictionary plugins folder

	# Needed by GUI
	insinto /usr/share/${PN}
	doins "${S}"/copying.html

	insinto /usr/share/${PN}/pixmaps
	doins "${S}"/pixmaps/*

	DHOME="$(python_get_sitedir)/opendict"
	insinto "${DHOME}/lib"
	doins -r "${S}"/lib/*
	exeinto "${DHOME}"
	python_convert_shebangs 2 opendict.py
	doexe opendict.py

	dosym "${DHOME}/opendict.py" /usr/bin/opendict

	domenu misc/${PN}.desktop

	insinto /usr/share/icons/hicolor/24x24/apps/
	newins "${S}/pixmaps/icon-24x24.png" opendict.png
	insinto /usr/share/icons/hicolor/32x32/apps/
	newins "${S}/pixmaps/icon-32x32.png" opendict.png
	insinto /usr/share/icons/hicolor/48x48/apps/
	newins "${S}/pixmaps/icon-48x48.png" opendict.png
	insinto /usr/share/icons/hicolor/scalable/apps/
	newins "${S}/pixmaps/SVG/icon-rune.svg" opendict.svg

	doman opendict.1
	dodoc README.txt TODO.txt doc/Plugin-HOWTO.html
}

pkg_postinst() {
	python_mod_optimize opendict
	gnome2_icon_cache_update

	echo
	elog "If you want system-wide plugins, unzip them into"
	elog "${ROOT}usr/share/${PN}/dictionaries/plugins"
	elog
	elog "Some are available from http://opendict.sourceforge.net/?cid=3"
	echo
}

pkg_postrm() {
	python_mod_cleanup opendict
	gnome2_icon_cache_update
}
