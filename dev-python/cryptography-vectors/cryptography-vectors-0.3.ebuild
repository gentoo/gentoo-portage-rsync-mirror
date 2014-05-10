# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cryptography-vectors/cryptography-vectors-0.3.ebuild,v 1.3 2014/05/10 05:23:29 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_2,3_3,3_4} pypy )

inherit distutils-r1

MY_PN=${PN/-/_}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Test vectors for the cryptography package"
HOMEPAGE="https://pypi.python.org/pypi/cryptography-vectors/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~mips ~x86 ~x86-fbsd"

S=${WORKDIR}/${MY_P}
