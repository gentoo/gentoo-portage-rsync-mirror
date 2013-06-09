# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rst2pdf/rst2pdf-0.93-r1.ebuild,v 1.3 2013/06/09 17:29:44 floppym Exp $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Tool for transforming reStructuredText to PDF using ReportLab"
HOMEPAGE="http://rst2pdf.ralsina.com.ar/ http://pypi.python.org/pypi/rst2pdf"
SRC_URI="http://rst2pdf.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="svg"

DEPEND="dev-python/docutils[${PYTHON_USEDEP}]
	virtual/python-imaging[${PYTHON_USEDEP}]
	dev-python/pdfrw[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	>=dev-python/reportlab-2.4[${PYTHON_USEDEP}]
	svg? ( media-gfx/svg2rlg )"
RDEPEND="${DEPEND}"

python_install_all() {
	dodoc doc/*.pdf
	doman doc/rst2pdf.1
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		elog "rst2pdf can work with the following packages for additional functionality:"
		elog "   dev-python/sphinx       - versatile documentation creation"
		elog "   dev-python/pythonmagick - image processing with ImageMagick"
		elog "   dev-python/matplotlib   - mathematical formulae"
		elog "It can also use wordaxe for hyphenation, but this package is not"
		elog "available in the portage tree yet. Please refer to the manual"
		elog "installed in /usr/share/doc/${PF}/ for more information."
	fi
}
