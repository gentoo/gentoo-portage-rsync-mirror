# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-scw/python-scw-0.4.7.ebuild,v 1.5 2012/02/24 08:34:07 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"
PYTHON_EXPORT_PHASE_FUNCTIONS="1"

inherit python

DESCRIPTION="Python binding for Scw."
HOMEPAGE="http://scwwidgets.googlepages.com/"
SRC_URI="http://scwwidgets.googlepages.com/${P}.tar.gz "

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/pygtk-2.4
	>=x11-libs/scw-0.4.0"
RDEPEND="${DEPEND}"

src_install() {
	python_src_install
	python_clean_installation_image
	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"
}
