# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/eyeD3/eyeD3-0.7.1.ebuild,v 1.9 2014/08/21 12:41:50 armin76 Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Module for manipulating ID3 (v1 + v2) tags in Python"
HOMEPAGE="http://eyed3.nicfit.net/"
SRC_URI="http://eyed3.nicfit.net/releases/${P}.tgz"

LICENSE="GPL-2"
SLOT="0.7"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND="!<${CATEGORY}/${PN}-0.6.18-r1:0"
DEPEND="${RDEPEND}
	dev-python/paver[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}/${PN}-build-task.patch" )

python_install_all() {
	dodoc AUTHORS ChangeLog README.rst
}
