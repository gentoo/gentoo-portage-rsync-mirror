# Copyright 2011-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/py-bcrypt/py-bcrypt-0.2.ebuild,v 1.1 2013/09/10 06:29:40 patrick Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="py-bcrypt is an implementation of the OpenBSD Blowfish password hashing algorithm"
HOMEPAGE="http://www.mindrot.org/projects/py-bcrypt
https://code.google.com/p/py-bcrypt/"
SRC_URI="http://www.mindrot.org/files/${PN}/${P}.tar.gz
http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD-4"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

DOCS=( ChangeLog LICENSE README TODO )
