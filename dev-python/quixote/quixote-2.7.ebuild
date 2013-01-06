# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/quixote/quixote-2.7.ebuild,v 1.5 2012/10/17 05:20:38 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 3.* 2.7-pypy-* *-jython"

inherit distutils

MY_P="${P/q/Q}"

DESCRIPTION="Python HTML templating framework for developing web applications"
HOMEPAGE="http://quixote.ca"
SRC_URI="http://quixote.ca/releases/${MY_P}.tar.gz"

LICENSE="CNRI-QUIXOTE-2.4"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"/${MY_P}

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DOCS="ACKS.txt CHANGES.txt doc/*.txt"

src_install() {
	distutils_src_install
	dohtml doc/*.html || die "dohtml failed"
}
