# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyGithub/PyGithub-1.10.0.ebuild,v 1.3 2013/01/20 20:31:47 floppym Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )
# TODO(floppym): Investigate test failures with other versions

inherit distutils-r1

DESCRIPTION="Python library to access the Github API v3"
HOMEPAGE="http://vincent-jacques.net/PyGithub"
# Use github since pypi is missing test data
SRC_URI="https://github.com/jacquev6/PyGithub/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
	esetup.py test
}
