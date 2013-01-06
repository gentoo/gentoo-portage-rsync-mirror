# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/trash-cli/trash-cli-0.12.9.14-r2.ebuild,v 1.4 2013/01/06 19:04:26 hasufell Exp $

EAPI=5

PYTHON_COMPAT=( python2_6 python2_7 )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="Python scripts to manipulate trash cans via the command line"
HOMEPAGE="https://github.com/andreafrancia/trash-cli"
SRC_URI="http://github.com/andreafrancia/${PN}/tarball/${PV} ->
	${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
