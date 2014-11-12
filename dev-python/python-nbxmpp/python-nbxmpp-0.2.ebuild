# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-nbxmpp/python-nbxmpp-0.2.ebuild,v 1.4 2014/11/12 13:06:18 blueness Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Python library to use Jabber/XMPP networks in a non-blocking way"
HOMEPAGE="http://python-nbxmpp.gajim.org/"
SRC_URI="http://python-nbxmpp.gajim.org/downloads/2 -> ${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

S="${WORKDIR}"/nbxmpp-${PV}
