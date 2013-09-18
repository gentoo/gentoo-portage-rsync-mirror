# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/grc/grc-1.5.ebuild,v 1.3 2013/09/18 13:46:59 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} pypy2_0 )

inherit eutils python-r1

DESCRIPTION="Generic Colouriser beautifies your logfiles or output of commands"
HOMEPAGE="http://kassiopeia.juls.savba.sk/~garabik/software/grc.html"
SRC_URI="http://kassiopeia.juls.savba.sk/~garabik/software/${PN}/${P/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="${PYTHON_DEPS}"
DEPEND=""

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-1.4-support-more-files.patch \
		"${FILESDIR}"/${PN}-1.4-ipv6.patch
}

src_install() {
	python_foreach_impl python_doscript grc grcat

	insinto /usr/share/grc
	doins conf.* "${FILESDIR}"/conf.*

	insinto /etc
	doins grc.conf

	dodoc README INSTALL TODO debian/changelog CREDITS
	doman grc.1 grcat.1
}
