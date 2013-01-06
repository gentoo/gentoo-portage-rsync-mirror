# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ropemacs/ropemacs-0.6.ebuild,v 1.2 2010/10/08 11:28:59 hwoarang Exp $

EAPI="3"

PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit distutils eutils

DESCRIPTION="Rope in Emacs"
HOMEPAGE="http://rope.sourceforge.net/ropemacs.html
	http://pypi.python.org/pypi/ropemacs"
SRC_URI="http://bitbucket.org/agr/ropemacs/get/8b277a188d00.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/rope
	dev-python/ropemode"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	distutils_src_prepare

	# Patch for nonexistent ropemode in setup.py
	epatch "${FILESDIR}/${P}-ropemode-dir.patch"
}

src_install() {
	distutils_src_install
	dodoc docs/*.txt || die
}

pkg_postinst() {
	distutils_pkg_postinst

	elog "In order to enable ropemacs support in Emacs, install"
	elog "app-emacs/pymacs and add the following line to your ~/.emacs file:"
	elog "  (pymacs-load \"ropemacs\" \"rope-\")"
}
