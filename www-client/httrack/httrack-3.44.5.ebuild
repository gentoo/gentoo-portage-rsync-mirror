# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/httrack/httrack-3.44.5.ebuild,v 1.2 2012/08/19 18:39:27 armin76 Exp $

EAPI="4"
inherit eutils

DESCRIPTION="HTTrack Website Copier, Open Source Offline Browser"
HOMEPAGE="http://www.httrack.com/"
SRC_URI="http://download.httrack.com/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="static-libs"

RDEPEND=">=sys-libs/zlib-1.2.5.1-r1"
DEPEND="${RDEPEND}"

DOCS=( AUTHORS README greetings.txt history.txt )

src_prepare() {
	epatch "${FILESDIR}"/${PN}-3.44.1+zlib-1.2.5.1.patch

	sed -i \
		"/^HelpHtml.*dir/s:${PN}:${PF}:" \
		"${S}"/html/Makefile.in || die
}

src_configure() {
	econf $(use_enable static-libs static) \
		--docdir=/usr/share/doc/${PF} \
		--htmldir=/usr/share/doc/${PF}/html
}

src_install() {
	default
	rm -rf "${ED}"/usr/share/doc/"${PN}" || die
}
