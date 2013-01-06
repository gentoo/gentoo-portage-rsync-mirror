# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/googlecl/googlecl-0.9.12-r1.ebuild,v 1.1 2011/02/23 07:54:33 wired Exp $

EAPI=3
PYTHON_DEPEND="2:2.5:2.7"

inherit distutils eutils

DESCRIPTION="Command line tools for the Google Data APIs"
HOMEPAGE="http://code.google.com/p/googlecl/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	dev-python/gdata
"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	# fix 'when' field not showing dates, bug #355913
	epatch "${FILESDIR}"/"${P}"-calendar_dates.patch

	distutils_src_prepare
}

src_install() {
	distutils_src_install

	dodoc changelog || die "dodoc failed"
	doman man/*.1 || die "doman failed"
}
