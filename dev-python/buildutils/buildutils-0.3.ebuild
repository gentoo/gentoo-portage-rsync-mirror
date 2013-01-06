# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/buildutils/buildutils-0.3.ebuild,v 1.6 2010/10/30 19:29:32 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

DESCRIPTION="Extensions for developing Python libraries and applications."
HOMEPAGE="http://buildutils.lesscode.org http://pypi.python.org/pypi/buildutils"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE="doc"

DEPEND="dev-python/setuptools
	doc? ( dev-python/pudge )"
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

src_prepare() {
	distutils_src_prepare

	# Enable pudge command.
	epatch "${FILESDIR}/${P}-pudge_addcommand.patch"

	sed -e "s/buildutils.command.publish/buildutils.publish_command.publish/" -i buildutils/test/test_publish.py || die "sed failed"
}

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		"$(PYTHON -f)" setup.py pudge || die "Generation of documentation failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r doc/html/* || die "dohtml failed"
	fi
}
