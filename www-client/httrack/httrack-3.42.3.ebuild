# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/httrack/httrack-3.42.3.ebuild,v 1.5 2012/08/19 18:39:27 armin76 Exp $

inherit versionator

MY_P="${PN}-$(get_version_component_range 1-2)-$(get_version_component_range 3)"
DESCRIPTION="HTTrack Website Copier, Open Source Offline Browser"
HOMEPAGE="http://www.httrack.com/"
SRC_URI="http://www.httrack.com/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

src_compile() {
	econf || die
	# won't compile in parallel
	emake -j1 || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS README greetings.txt history.txt
	dohtml httrack-doc.html
}
