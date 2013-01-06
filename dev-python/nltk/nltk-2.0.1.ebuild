# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/nltk/nltk-2.0.1.ebuild,v 1.2 2012/10/19 04:06:35 patrick Exp $

EAPI=4

PYTHON_DEPEND="2"
PYTHON_USE_WITH="tk(+) xml(+)"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Natural Language Toolkit"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
HOMEPAGE="http://nltk.org/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND="dev-python/numpy
	dev-python/pyyaml"
DEPEND="${RDEPEND}
	app-arch/unzip"
