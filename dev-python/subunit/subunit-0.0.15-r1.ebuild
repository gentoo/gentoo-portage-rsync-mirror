# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/subunit/subunit-0.0.15-r1.ebuild,v 1.1 2013/12/11 02:33:29 floppym Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy2_0 )

inherit distutils-r1 eutils

DESCRIPTION="A streaming protocol for test results"
HOMEPAGE="https://launchpad.net/subunit http://pypi.python.org/pypi/python-subunit"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="Apache-2.0 BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~x86 ~x86-fbsd"
#need to keyword the following in =dev-python/extras-0.0.3 then readd the keywords here
#ia64 s390 sh sparc amd64-fbsd
IUSE=""

RDEPEND=">=dev-python/testtools-0.9.30[${PYTHON_USEDEP}]
	dev-python/extras[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-lang/perl
	dev-libs/check
	dev-util/cppunit
	virtual/pkgconfig"

src_configure() {
	econf
	distutils-r1_src_configure
}

src_compile() {
	emake
	distutils-r1_src_compile
}

src_install() {
	local targets=(
		install-include_subunitHEADERS
		install-pcdataDATA
		install-exec-local
		install-libLTLIBRARIES
	)
	emake DESTDIR="${D}" "${targets[@]}"
	prune_libtool_files
	distutils-r1_src_install
}
