# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/redirbot/redirbot-0.0.5.ebuild,v 1.3 2014/07/06 12:54:38 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )
DOCS=( ChangeLog README.rst  )

inherit distutils-r1

DESCRIPTION="IRCBot, telling people they should contact you on different nickname"
HOMEPAGE="https://github.com/yaccz/redirbot"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/twisted-core-11.1.0
	dev-python/twisted-words
"
RDEPEND="${DEPEND}"
