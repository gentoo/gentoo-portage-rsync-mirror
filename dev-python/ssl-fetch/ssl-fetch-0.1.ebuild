# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ssl-fetch/ssl-fetch-0.1.ebuild,v 1.2 2014/05/05 15:51:04 jer Exp $

EAPI="5"

PYTHON_COMPAT=(python{2_7,3_2,3_3})

inherit distutils-r1 python-r1

DESCRIPTION="A small convinience library for fetching files securely"
HOMEPAGE="https://github.com/dol-sen/ssl-fetch"
SRC_URI="http://dev.gentoo.org/~dolsen/releases/ssl-fetch/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS="~amd64 ~hppa ~x86"

DEPEND=""

# requests dropped py-3.2 support in >=2.2.0
RDEPEND="${DEPEND}
	>=dev-python/requests-1.2.1
	python_targets_python3_2? ( <=dev-python/requests-2.1.0 )
	python_targets_python2_7? (
		dev-python/ndg-httpsclient[python_targets_python2_7]
		dev-python/pyasn1[python_targets_python2_7]
		>=dev-python/pyopenssl-0.13[python_targets_python2_7]
		)
	"

python_install_all() {
	distutils-r1_python_install_all
}

pkg_postinst() {
	einfo
	einfo "This is beta software."
	einfo "The APIs it installs should be considered unstable"
	einfo "and are subject to change in these early versions."
	einfo
	einfo "Please file any enhancement requests, or bugs"
	einfo "at https://github.com/dol-sen/ssl-fetch/issues"
	einfo "I am also on IRC @ #gentoo-portage, #gentoo-keys,... of the freenode network"
	einfo
}
