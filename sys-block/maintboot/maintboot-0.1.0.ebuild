# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/maintboot/maintboot-0.1.0.ebuild,v 1.1 2015/04/03 08:05:19 idella4 Exp $

EAPI="5"

PYTHON_COMPAT=( python{3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Runs maintenance tasks outside the OS"
HOMEPAGE="https://github.com/g2p/maintboot"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
