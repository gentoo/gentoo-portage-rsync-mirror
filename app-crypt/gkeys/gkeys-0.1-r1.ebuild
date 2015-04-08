# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gkeys/gkeys-0.1-r1.ebuild,v 1.3 2015/01/13 06:19:41 steev Exp $

EAPI="5"

PYTHON_COMPAT=(python{2_7,3_3,3_4})

inherit distutils-r1

DESCRIPTION="An OpenPGP/GPG key management tool for seed files and keyrings"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:Gentoo-keys"
SRC_URI="http://dev.gentoo.org/~dolsen/releases/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS="~amd64 ~arm ~x86"

DEPEND=""
RDEPEND="${DEPEND}
	app-crypt/gnupg
	>=dev-python/pyGPG-0.1[${PYTHON_USEDEP}]
	>=dev-python/ssl-fetch-0.3[${PYTHON_USEDEP}]
	dev-python/snakeoil[${PYTHON_USEDEP}]
	>=app-crypt/gentoo-keys-201501052117
	"

python_install_all() {
	distutils-r1_python_install_all
	keepdir /var/log/gkeys
	fperms g+w /var/log/gkeys
}

pkg_preinst() {
	chgrp users "${D}"/var/log/gkeys
}

pkg_postinst() {
	einfo "Fetching Gentoo Developer seed file..."
	gkeys fetch-seed -C gentoo-devs || die "Unable to fetch seeds"
	einfo "This is experimental software."
	einfo "The API's it installs should be considered unstable"
	einfo "and are subject to change."
	einfo
	einfo "Please file any enhancement requests, or bugs"
	einfo "at https://bugs.gentoo.org"
	einfo "We are also on IRC @ #gentoo-keys of the Freenode network"
	einfo
	ewarn "There may be some Python 3 compatibility issues still."
	ewarn "Please help us debug, fix and report them in Bugzilla."
}
