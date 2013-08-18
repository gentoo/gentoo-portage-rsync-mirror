# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/virtualenv-clone/virtualenv-clone-0.2.4-r1.ebuild,v 1.3 2013/08/18 13:25:42 ago Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} python{3_1,3_2} )

inherit distutils-r1

DESCRIPTION="A script for cloning a non-relocatable virtualenv."
HOMEPAGE="http://github.com/edwardgeorge/virtualenv-clone"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
