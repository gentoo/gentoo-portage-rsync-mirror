# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/lightblue/lightblue-0.4.ebuild,v 1.4 2013/11/07 02:50:27 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Cross-platform Bluetooth API for Python which provides simple access to Bluetooth operations"
HOMEPAGE="http://lightblue.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-libs/openobex-1.3
	>=dev-python/pybluez-0.9"
RDEPEND="${DEPEND}"
RESTRICT_PYTHON_ABIS="3.*"
