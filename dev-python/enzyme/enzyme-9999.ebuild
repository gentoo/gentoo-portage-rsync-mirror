# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/enzyme/enzyme-9999.ebuild,v 1.1 2013/04/24 07:02:39 maksbotan Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1 git-2

DESCRIPTION="Python module to parse metadata in video files"
HOMEPAGE="https://github.com/Diaoul/enzyme"
EGIT_REPO_URI="git://github.com/Diaoul/enzyme.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"
