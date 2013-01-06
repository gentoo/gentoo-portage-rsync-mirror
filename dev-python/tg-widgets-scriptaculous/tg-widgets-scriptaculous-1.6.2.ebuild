# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tg-widgets-scriptaculous/tg-widgets-scriptaculous-1.6.2.ebuild,v 1.3 2011/04/12 16:20:27 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit distutils

DESCRIPTION="TurboGears widget wrapper for the Scriptaculous JavaScript library"
HOMEPAGE="http://www.turbogears.org/widgets/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-python/turbogears"
DEPEND="${RDEPEND}"

PYTHON_MODNAME="scriptaculous"
