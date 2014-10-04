# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/griffith/griffith-9999.ebuild,v 1.12 2014/10/04 11:33:14 hwoarang Exp $

EAPI="4"
ESVN_REPO_URI="http://svn.berlios.de/svnroot/repos/griffith/trunk"
PYTHON_USE_WITH=sqlite

inherit eutils python multilib subversion

ARTWORK_PV="0.9.4"

DESCRIPTION="Movie collection manager"
HOMEPAGE="http://griffith.berlios.de/"
SRC_URI="mirror://berlios/griffith/${PN}-extra-artwork-${ARTWORK_PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="doc"

RDEPEND="virtual/python-imaging
	gnome-base/libglade
	dev-python/pyxml
	>=dev-python/pygtk-2.6.1:2
	dev-python/pygobject:2
	>=dev-python/sqlalchemy-0.5.2
	>=dev-python/reportlab-1.19
	>=dev-python/sqlalchemy-0.4.6"
DEPEND="${RDEPEND}
	doc? ( app-text/docbook2X )"

pkg_setup() {
	ewarn "This version is _not_ compatible with databases created with previous versions"
	ewarn "of griffith and the database upgrade is currently (16 Aug 2008) broken."
	ewarn "Please move your ~/.griffith away before starting."
}

src_unpack() {
	subversion_src_unpack
}

src_prepare() {
	sed -i \
		-e 's#/pl/#/pl.UTF-8/#' \
		docs/pl/Makefile || die "sed failed"

	sed -i \
		-e 's/ISO-8859-1/UTF-8/' \
		lib/gconsole.py || die "sed failed"

	sed -i \
		-e "s|locations\['lib'\], '..')|locations\['lib'\], '..', '..', 'share', 'griffith')|" \
		lib/initialize.py || die "sed failed"
}

src_compile() {
	# Nothing to compile and default `emake` spews an error message
	true
}

src_install() {
	use doc || { sed -i -e '/docs/d' Makefile || die ; }

	python_version
	emake \
		LIBDIR="${D}/usr/$(get_libdir)/griffith" \
		DESTDIR="${D}" DOC2MAN=docbook2man.pl install
	dodoc AUTHORS ChangeLog README THANKS TODO NEWS TRANSLATORS

	cd "${WORKDIR}/${PN}-extra-artwork-${ARTWORK_PV}/"
	emake DESTDIR="${D}" install
}

pkg_postinst() {
	python_mod_optimize /usr/$(get_libdir)/${PN}
	einfo
	einfo "${PN} can make use of the following optional dependencies"
	einfo "dev-python/chardet: CSV file encoding detections"
	einfo "dev-python/mysql-python: Python interface for MySQL connectivity"
	einfo ">=dev-python/psycopg-2.4: Python interface for PostgreSQL connectivity"
	einfo
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/${PN}
}
