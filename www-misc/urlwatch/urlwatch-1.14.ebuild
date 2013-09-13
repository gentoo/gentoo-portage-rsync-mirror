# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/urlwatch/urlwatch-1.14.ebuild,v 1.3 2013/09/13 21:34:32 mgorny Exp $

EAPI="4"
PYTHON_DEPEND="2:2.5 3:3.2"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"

inherit distutils eutils

DESCRIPTION="A tool for monitoring webpages for updates"
HOMEPAGE="http://thp.io/2008/urlwatch/ http://pypi.python.org/pypi/urlwatch"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="xmpp"

RDEPEND="xmpp? ( dev-python/xmpppy )
	virtual/python-futures"
DEPEND="${RDEPEND}"

src_prepare() {
	use xmpp && epatch "${FILESDIR}"/${PN}-xmpp.patch
	sed -i -e "s/^os.unlink/#\0/" setup.py || die

	distutils_src_prepare

	2to3_conversion() {
		[[ "${PYTHON_ABI}" == 2.* ]] && return
		2to3-${PYTHON_ABI} -nw --no-diffs urlwatch lib/urlwatch/*.py \
			examples/hooks.py.example setup.py || die "2to3 failed"
	}
	python_execute_function -s 2to3_conversion
}
