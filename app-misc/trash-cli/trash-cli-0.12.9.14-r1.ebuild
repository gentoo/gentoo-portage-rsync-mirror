# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/trash-cli/trash-cli-0.12.9.14-r1.ebuild,v 1.3 2012/11/20 20:46:12 ago Exp $

EAPI=4

PYTHON_COMPAT="python2_6 python2_7"

inherit python-distutils-ng vcs-snapshot

DESCRIPTION="Python scripts to manipulate trash cans via the command line"
HOMEPAGE="https://github.com/andreafrancia/trash-cli"
SRC_URI="http://github.com/andreafrancia/${PN}/tarball/${PV} ->
	${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-python/setuptools"
