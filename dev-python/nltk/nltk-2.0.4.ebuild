# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/nltk/nltk-2.0.4.ebuild,v 1.3 2015/03/18 02:14:08 zerochaos Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE="tk?,xml(+)"

inherit distutils-r1 eutils

DESCRIPTION="Natural Language Toolkit"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
HOMEPAGE="http://nltk.org/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE="numpy tk"

RDEPEND="${RDEPEND}
	numpy? ( dev-python/numpy[${PYTHON_USEDEP}] )
	dev-python/pyyaml[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	app-arch/unzip"

src_prepare() {
	epatch "${FILESDIR}"/fix-newer-setuptools.patch
	distutils-r1_src_prepare
}
