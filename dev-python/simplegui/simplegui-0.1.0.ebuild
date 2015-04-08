# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/simplegui/simplegui-0.1.0.ebuild,v 1.4 2014/06/14 09:34:41 phajdan.jr Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 python3_2 python3_3 )
PYTHON_REQ_USE="tk"
DISTUTILS_IN_SOURCE_BUILD=1

inherit distutils-r1

DESCRIPTION="Simplified GUI generation using Tkinter"
HOMEPAGE="http://florian-berger.de/en/software/simplegui"
SRC_URI="http://static.florian-berger.de/simplegui-0.1.0.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="app-arch/unzip
	dev-python/cx_Freeze[${PYTHON_USEDEP}]"

python_compile() {
	if [[ ${EPYTHON} == python3.* ]]; then
		2to3 --no-diffs -w *.py || die
	fi

	distutils-r1_python_compile
}
