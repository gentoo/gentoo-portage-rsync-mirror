# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/enzyme/enzyme-0.2.ebuild,v 1.2 2015/04/08 08:04:59 mgorny Exp $

EAPI="5"
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Python module to parse metadata in video files"
HOMEPAGE="https://github.com/Diaoul/enzyme"
SRC_URI="https://github.com/Diaoul/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"
