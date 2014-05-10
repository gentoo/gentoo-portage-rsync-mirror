# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/duplicity/duplicity-0.6.23-r1.ebuild,v 1.4 2014/05/10 13:40:50 ago Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Secure backup system using gnupg to encrypt data"
HOMEPAGE="http://www.nongnu.org/duplicity/"
SRC_URI="http://code.launchpad.net/${PN}/0.6-series/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="s3"

DEPEND="
	net-libs/librsync
	app-crypt/gnupg
	dev-python/lockfile
"
RDEPEND="${DEPEND}
	dev-python/paramiko[${PYTHON_USEDEP}]
	s3? ( dev-python/boto[${PYTHON_USEDEP}] )
"

python_prepare_all() {
	distutils-r1_python_prepare_all

	sed -i "s/'COPYING',//" setup.py || die "Couldn't remove unnecessary COPYING file."
}

pkg_postinst() {
	einfo "Duplicity has many optional dependencies to support various backends."
	einfo "Currently it's up to you to install them as necessary."
}
