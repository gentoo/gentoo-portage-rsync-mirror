# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyptlib/pyptlib-0.0.5.ebuild,v 1.1 2013/10/06 16:41:31 blueness Exp $

EAPI="5"
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Python library for tor's pluggable transport managed-proxy protocol"
HOMEPAGE="https://gitweb.torproject.org/pluggable-transports/pyptlib.git"
SRC_URI="mirror://pypi/p/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DOCS=( README.rst TODO )
