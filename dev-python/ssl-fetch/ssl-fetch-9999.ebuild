# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ssl-fetch/ssl-fetch-9999.ebuild,v 1.1 2014/03/02 05:42:49 dolsen Exp $

EAPI="5"

PYTHON_COMPAT=(python{2_6,2_7,3_2,3_3})

EGIT_BRANCH="master"

inherit distutils-r1 python-r1 git-2

EGIT_REPO_URI="git://github.com/dol-sen/ssl-fetch.git"

DESCRIPTION="A small convinience library for fetching files securely"
HOMEPAGE="https://github.com/dol-sen/ssl-fetch"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS=""

DEPEND=""

# requests dropped py-3.2 support in >=2.2.0
RDEPEND="${DEPEND}
	>=dev-python/requests-1.2.1
	python_targets_python3_2? ( <=dev-python/requests-2.1.0 )
	python_targets_python2_6? (
		dev-python/ndg-httpsclient[python_targets_python2_6]
		dev-python/pyasn1[python_targets_python2_6]
		>=dev-python/pyopenssl-0.13[python_targets_python2_6]
		)
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
	einfo "This is experimental software."
	einfo "The APIs it installs should be considered unstable"
	einfo "and are subject to change."
	einfo
	einfo "Please file any enhancement requests, or bugs"
	einfo "at https://github.com/dol-sen/ssl-fetch/issues"
	einfo "I am also on IRC @ #gentoo-portage, #gentoo-keys,... of the freenode network"
	einfo
}
