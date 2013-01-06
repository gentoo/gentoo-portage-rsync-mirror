# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rst2pdf/rst2pdf-0.16.ebuild,v 1.4 2011/12/14 10:27:49 floppym Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="Tool for transforming reStructuredText to PDF using ReportLab"
HOMEPAGE="http://code.google.com/p/rst2pdf/ http://pypi.python.org/pypi/rst2pdf"
SRC_URI="http://rst2pdf.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-python/docutils
	dev-python/imaging
	dev-python/pygments
	>=dev-python/reportlab-2.4"
RDEPEND="${DEPEND}"

DOCS="Contributors.txt CHANGES.txt README.txt"

src_install() {
	distutils_src_install

	insinto /usr/share/doc/${PF}/examples
	doins doc/montecristo/* || die "doins failed"
}

pkg_postinst() {
	distutils_pkg_postinst

	elog "rst2pdf can work with the following packages for additional functionality:"
	elog "   dev-python/sphinx       - versatile documentation creation"
	elog "   dev-python/pythonmagick - image processing with ImageMagick"
	elog "   dev-python/matplotlib   - mathematical formulae"
	elog "   media-gfx/uniconvertor  - vector image format conversion"
	elog "It can also use wordaxe for hyphenation, but this package is not"
	elog "available in the portage tree yet. Please refer to the manual"
	elog "installed in /usr/share/doc/${PF}/ for more information."
}
