# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/googsystray/googsystray-1.3.1.ebuild,v 1.2 2012/02/25 12:35:39 patrick Exp $

EAPI="3"

SUPPORT_PYTHON_ABIS=1
PYTHON_DEPEND="2:2.6"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"

inherit distutils

DESCRIPTION="System tray application for Google Voice, GMail, Google Calendar, Google Reader, and Google Wave."
HOMEPAGE="http://googsystray.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=" >=dev-python/pygtk-2.14"
RDEPEND="${DEPEND}"
