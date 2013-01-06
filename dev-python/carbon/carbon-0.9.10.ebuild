# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/carbon/carbon-0.9.10.ebuild,v 1.1 2012/06/22 15:23:20 marienz Exp $

EAPI="4"

PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"
SUPPORT_PYTHON_ABIS="1"
inherit distutils eutils

DESCRIPTION="Backend data caching and persistence daemon for Graphite"
HOMEPAGE="http://graphite.wikidot.com/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/twisted
	dev-python/whisper
	dev-python/txAMQP"

src_prepare() {
	# This sets prefix to /opt/graphite. We want FHS-style paths instead.
	rm setup.cfg || die
	# Do not install the configuration and data files. We install them
	#somewhere sensible by hand.
	epatch "${FILESDIR}/no-data-files.patch"

	distutils_src_prepare
}

src_install() {
	distutils_src_install

	insinto /etc/carbon
	doins conf/*

	dodir /var/log/carbon /var/lib/carbon/{whisper,lists,rrd}
}

pkg_postinst() {
	einfo 'This ebuild installs carbon into FHS-style paths.'
	einfo 'You will probably have to set GRAPHITE_CONF_DIR to /etc/carbon'
	einfo 'and GRAPHITE_STORAGE_DIR to /var/lib/carbon to make use of this'
	einfo '(see /etc/carbon/carbon.conf.example).'
}
