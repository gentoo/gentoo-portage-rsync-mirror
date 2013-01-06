# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-docs/python-docs-3.1.4.ebuild,v 1.2 2012/02/19 01:40:33 hwoarang Exp $

EAPI="3"

DESCRIPTION="HTML documentation for Python"
HOMEPAGE="http://www.python.org/doc/"
SRC_URI="http://www.python.org/ftp/python/doc/${PV}/python-${PV}-docs-html.tar.bz2"

LICENSE="PSF-2"
SLOT="3.1"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/python-${PV}-docs-html"

src_install() {
	docinto html
	cp -R [a-z]* _static "${ED}usr/share/doc/${PF}/html"

	echo "PYTHONDOCS_${SLOT//./_}=\"${EPREFIX}/usr/share/doc/${PF}/html/library\"" > "60python-docs-${SLOT}"
	doenvd "60python-docs-${SLOT}"
}

pkg_postrm() {
	if ! has_version "<dev-python/python-docs-${SLOT}_alpha" && ! has_version ">=dev-python/python-docs-${SLOT%.*}.$((${SLOT#*.}+1))_alpha"; then
		rm -f "${EROOT}etc/env.d/65python-docs"
	fi
}
