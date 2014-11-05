# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/yubikey-neo-manager/yubikey-neo-manager-0.2.5.ebuild,v 1.1 2014/11/05 16:23:58 zerochaos Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Cross platform personalization tool for the YubiKey NEO"
HOMEPAGE="https://developers.yubico.com/yubikey-neo-manager/"
SRC_URI="https://developers.yubico.com/${PN}/Releases/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

CDEPEND="dev-python/pyside[webkit,${PYTHON_USEDEP}]
	app-crypt/libu2f-host
	app-crypt/libykneomgr
	sys-auth/ykpers"

DEPEND="dev-python/docutils[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/nose-1.0[${PYTHON_USEDEP}]
	dev-python/pycrypto[${PYTHON_USEDEP}]
	${CDEPEND}"

RDEPEND="${CDEPEND}"
