# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/texi2html/texi2html-5.0-r1.ebuild,v 1.15 2012/09/24 14:30:37 armin76 Exp $

EAPI=4

DESCRIPTION="Perl script that converts Texinfo to HTML"
HOMEPAGE="http://www.nongnu.org/texi2html/"
SRC_URI="mirror://nongnu/${PN}/${P}.tar.bz2"

LICENSE="CCPL-ShareAlike-1.0 FDL-1.3 GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="unicode"

RDEPEND=">=dev-lang/perl-5.10.1
	>=dev-perl/libintl-perl-1.200
	unicode? (
		dev-perl/Text-Unidecode
		dev-perl/Unicode-EastAsianWidth
		)"
DEPEND="${RDEPEND}"

DOCS="AUTHORS ChangeLog NEWS README TODO"

RESTRICT="test" #411523

src_prepare() {
	# On FreeBSD this script is used instead of GNU install but it comes without
	# executable pemissions... Fix it!
	chmod +x install-sh || die
}

src_configure() {
	local myconf
	use unicode && myconf='--with-external-Unicode-EastAsianWidth'

	econf \
		--with-external-libintl-perl \
		$(use_with unicode unidecode) \
		${myconf}
}

src_install() {
	default
	rm -f "${ED}"/usr/share/${PN}/images/{COPYING*,GPL,README}
}

pkg_preinst() {
	rm -f "${EROOT}"/usr/bin/${PN}
}
