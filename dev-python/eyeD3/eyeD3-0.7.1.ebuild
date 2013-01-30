# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/eyeD3/eyeD3-0.7.1.ebuild,v 1.3 2013/01/30 20:03:40 jer Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Module for manipulating ID3 (v1 + v2) tags in Python"
HOMEPAGE="http://eyed3.nicfit.net/"
SRC_URI="http://eyed3.nicfit.net/releases/${P}.tgz"

LICENSE="GPL-2"
SLOT="0.7"
KEYWORDS="~amd64 ~hppa ~x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND="!<${CATEGORY}/${PN}-0.6.18-r1:0"
DEPEND="${RDEPEND}
	dev-python/paver"

src_install() {
	dodoc AUTHORS ChangeLog README.rst
	distutils-r1_src_install
}
