# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/bzr-explorer/bzr-explorer-1.2.2.ebuild,v 1.3 2012/10/13 11:45:39 hwoarang Exp $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_PV=${PV/_beta/b}
MY_PV=${MY_PV/_rc/rc}
LPV=${MY_PV}
MY_P=${PN}-${MY_PV}

DESCRIPTION="A high level interface to all commonly used Bazaar features"
HOMEPAGE="https://launchpad.net/bzr-explorer"
SRC_URI="http://launchpad.net/${PN}/1.2/${LPV}/+download/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"

KEYWORDS="amd64 ~x86"
IUSE="gtk"

DEPEND=""
RDEPEND=">=dev-vcs/bzr-2.3
		>=dev-vcs/qbzr-0.22
		gtk? ( dev-vcs/bzr-gtk )"
