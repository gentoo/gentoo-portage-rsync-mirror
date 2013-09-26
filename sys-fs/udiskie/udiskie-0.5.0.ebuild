# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/udiskie/udiskie-0.5.0.ebuild,v 1.1 2013/09/26 05:38:38 ssuominen Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )
inherit distutils-r1

DESCRIPTION="An automatic disk mounting service using udisks"
HOMEPAGE="http://pypi.python.org/pypi/udiskie http://github.com/coldfix/udiskie"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}-1.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND=">=dev-python/dbus-python-1.2.0
	>=dev-python/notify-python-0.1.1-r2
	>=dev-python/pygobject-2.28.6-r53:2
	>=dev-python/pyxdg-0.25
	>=sys-fs/udisks-1.0.4-r5:0"
DEPEND=""

S=${WORKDIR}/${P}-1
