# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/inotify-tools/inotify-tools-3.13-r1.ebuild,v 1.4 2009/11/26 10:37:20 maekke Exp $

EAPI="2"

DESCRIPTION="a set of command-line programs providing a simple interface to inotify"
HOMEPAGE="http://inotify-tools.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm hppa x86"
IUSE="doc"

DEPEND="doc? ( app-doc/doxygen )"
RDEPEND=""

src_prepare() {
	# timestamps are busted in tarball
	find . -type f -exec touch -r configure {} +
}

src_configure() {
	# only docs installed are doxygen ones, so use /html
	econf \
		--docdir=/usr/share/doc/${PF}/html \
		$(use_enable doc doxygen) \
		|| die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README NEWS AUTHORS ChangeLog
}
