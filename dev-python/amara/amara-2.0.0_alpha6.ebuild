# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/amara/amara-2.0.0_alpha6.ebuild,v 1.1 2012/05/16 09:39:14 dev-zero Exp $

EAPI=4

inherit distutils eutils

MY_PN="Amara"
MY_P="${MY_PN}-${PV/_alpha/a}"

DESCRIPTION="Library for XML processing in Python."
HOMEPAGE="http://wiki.xml3k.org/Amara2"
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND=">=dev-libs/expat-2.1.0-r2[unicode]
	dev-lang/python[wide-unicode]
	dev-python/html5lib"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	distutils_src_prepare

	epatch \
		"${FILESDIR}/${PV}-unbundle-expat.patch" \
		"${FILESDIR}/${PV}-unbundle-python-libs.patch"
}

src_install() {
	DOCS="CHANGES"

	distutils_src_install

	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r demo
	fi
}
