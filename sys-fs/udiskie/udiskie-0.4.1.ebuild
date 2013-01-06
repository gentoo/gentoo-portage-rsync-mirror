# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/udiskie/udiskie-0.4.1.ebuild,v 1.4 2012/11/01 23:37:52 ssuominen Exp $

EAPI=4

PYTHON_DEPEND="2:2.7"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="2.[456] 3.*"

inherit distutils

DESCRIPTION="An automatic disk mounting service using udisks"
HOMEPAGE="http://bitbucket.org/byronclark/udiskie"
SRC_URI="mirror://bitbucket/byronclark/${PN}/downloads/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=dev-python/dbus-python-1.1.1
	>=dev-python/notify-python-0.1.1-r2
	>=dev-python/pygobject-2.28.6-r50:2
	>=dev-python/pyxdg-0.23
	>=sys-fs/udisks-1.0.4-r2:0"
DEPEND=""
