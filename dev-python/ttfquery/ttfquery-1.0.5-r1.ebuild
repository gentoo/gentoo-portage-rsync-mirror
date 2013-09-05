# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ttfquery/ttfquery-1.0.5-r1.ebuild,v 1.4 2013/09/05 18:46:57 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} pypy2_0 )

inherit distutils-r1

MY_PN="TTFQuery"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Font metadata and glyph outline extraction utility library"
HOMEPAGE="http://ttfquery.sourceforge.net/ http://pypi.python.org/pypi/TTFQuery"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc x86"
IUSE=""

DEPEND="dev-python/fonttools
	dev-python/numpy"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
