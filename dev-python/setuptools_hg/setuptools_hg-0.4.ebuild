# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/setuptools_hg/setuptools_hg-0.4.ebuild,v 1.2 2014/08/10 21:21:52 slyfox Exp $

EAPI="4"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Setuptools/distribute plugin for finding files under Mercurial version control"
HOMEPAGE="http://pypi.python.org/pypi/setuptools_hg http://bitbucket.org/jezdez/setuptools_hg/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

RDEPEND="dev-vcs/mercurial"
DEPEND="${RDEPEND}
	dev-python/setuptools"

PYTHON_MODNAME="${PN}.py"
