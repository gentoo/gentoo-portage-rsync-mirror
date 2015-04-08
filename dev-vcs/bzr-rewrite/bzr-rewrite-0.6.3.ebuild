# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/bzr-rewrite/bzr-rewrite-0.6.3.ebuild,v 1.7 2013/08/06 19:10:30 fauli Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Bazaar plugin that adds support for rebasing, similar to the functionality in git"
HOMEPAGE="https://launchpad.net/bzr-rewrite"
SRC_URI="http://launchpad.net/bzr-rewrite/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 x86"
IUSE=""

DEPEND=">=dev-vcs/bzr-2.5.0
	!dev-vcs/bzr-rebase"
RDEPEND="${DEPEND}
	!<dev-vcs/bzr-svn-0.6"
