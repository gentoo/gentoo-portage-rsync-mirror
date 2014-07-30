# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pypax/pypax-0.8.6.ebuild,v 1.1 2014/07/30 17:00:12 blueness Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy pypy2_0 )

inherit distutils-r1

DESCRIPTION="Python module to get or set either PT_PAX and/or XATTR_PAX flags"
HOMEPAGE="http://dev.gentoo.org/~blueness/elfix/
	http://www.gentoo.org/proj/en/hardened/pax-quickstart.xml"
SRC_URI="http://dev.gentoo.org/~blueness/elfix/elfix-${PV}.tar.gz"

S="${WORKDIR}/elfix-${PV}/scripts"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="+ptpax +xtpax"

REQUIRED_USE="|| ( ptpax xtpax )"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	ptpax? ( dev-libs/elfutils )
	xtpax? ( sys-apps/attr )"

RDEPEND=""

src_compile() {
	unset PTPAX
	unset XTPAX
	use ptpax && export PTPAX="yes"
	use xtpax && export XTPAX="yes"
	distutils-r1_src_compile
}
