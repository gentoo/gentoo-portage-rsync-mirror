# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyutp/pyutp-0_pre20130213.ebuild,v 1.1 2013/02/13 20:34:30 ssuominen Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2} )
MY_P=${P/py/lib}

inherit distutils-r1

DESCRIPTION="uTorrent Transport Protocol library"
HOMEPAGE="http://github.com/bittorrent/libutp"
SRC_URI="http://dev.gentoo.org/~ssuominen/${MY_P}.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=net-libs/libutp-${PV}"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}/${PN}
