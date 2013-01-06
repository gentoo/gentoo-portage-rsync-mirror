# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/xhtml2pdf/xhtml2pdf-0.0.3.ebuild,v 1.5 2012/05/21 17:35:56 nelchael Exp $

EAPI="4"

PYTHON_COMPAT="python2_5 python2_6 python2_7"

inherit python-distutils-ng

DESCRIPTION="PDF generator using HTML and CSS"
HOMEPAGE="http://www.xhtml2pdf.com/ http://pypi.python.org/pypi/xhtml2pdf"
SRC_URI="mirror://pypi/${PN::1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/html5lib
	dev-python/imaging
	dev-python/pyPdf
	dev-python/reportlab"
RDEPEND="${DEPEND}"
