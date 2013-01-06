# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/texamator/texamator-1.5b.ebuild,v 1.2 2011/04/25 19:27:48 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit multilib python

MY_PN=TeXamator

DESCRIPTION="A program aimed at helping you making your exercise sheets"
HOMEPAGE="http://snouffy.free.fr/blog-en/index.php/category/TeXamator"
SRC_URI="http://snouffy.free.fr/blog-en/public/${MY_PN}/${MY_PN}.v.${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/PyQt4
	app-text/dvipng
	virtual/latex-base"
RDEPEND="${DEPEND}"

S=${WORKDIR}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_install() {
	python_need_rebuild

	dodoc ${MY_PN}/README
	rm -f ${MY_PN}/README

	insinto /usr/$(get_libdir)
	doins -r ${MY_PN} || die

	dobin "${FILESDIR}"/${PN} || die
}

pkg_postinst() {
	python_mod_optimize /usr/$(get_libdir)/${MY_PN}
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/${MY_PN}
}
