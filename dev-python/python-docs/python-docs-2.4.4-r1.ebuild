# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-docs/python-docs-2.4.4-r1.ebuild,v 1.8 2011/11/28 19:52:06 hwoarang Exp $

EAPI="3"

DESCRIPTION="HTML documentation for Python"
HOMEPAGE="http://www.python.org/doc/"
SRC_URI="http://www.python.org/ftp/python/doc/${PV}/html-${PV}.tar.bz2
	http://www.python.org/ftp/python/doc/${PV}/info-${PV}.tar.bz2"

LICENSE="PSF-2"
SLOT="2.4"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"

src_unpack() {
	unpack html-${PV}.tar.bz2
	mkdir "${S}/info"
	cd "${S}/info"
	unpack info-${PV}.tar.bz2
}

src_prepare() {
	rm -f README python.dir
}

src_install() {
	docinto html
	cp -R "${S}/Python-Docs-${PV}/"* "${ED}usr/share/doc/${PF}/html"

	insinto /usr/share/info
	doins "${S}/info/"*

	echo "PYTHONDOCS_${SLOT//./_}=\"${EPREFIX}/usr/share/doc/${PF}/html\"" > "60python-docs-${SLOT}"
	doenvd "60python-docs-${SLOT}"
}

pkg_postrm() {
	if ! has_version "<dev-python/python-docs-${SLOT}_alpha" && ! has_version ">=dev-python/python-docs-${SLOT%.*}.$((${SLOT#*.}+1))_alpha"; then
		rm -f "${EROOT}etc/env.d/65python-docs"
	fi
}
