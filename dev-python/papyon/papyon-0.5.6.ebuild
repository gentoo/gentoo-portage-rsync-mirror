# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/papyon/papyon-0.5.6.ebuild,v 1.5 2012/01/20 17:54:08 ssuominen Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"

inherit distutils python

DESCRIPTION="Python MSN IM protocol implementation forked from pymsn"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/papyon"
SRC_URI="http://www.freedesktop.org/software/${PN}/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=dev-python/pygobject-2.10:2
	>=dev-python/pyopenssl-0.6
	dev-python/gst-python
	dev-python/pycrypto
	net-libs/farsight2[python]"
DEPEND="${RDEPEND}"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	distutils_src_prepare
	python_convert_shebangs -r 2 .
}
