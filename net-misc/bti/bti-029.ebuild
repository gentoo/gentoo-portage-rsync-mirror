# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bti/bti-029.ebuild,v 1.2 2012/05/05 03:20:45 jdhore Exp $

EAPI=2

inherit bash-completion eutils

DESCRIPTION="A command line twitter/identi.ca client"
HOMEPAGE="http://gregkh.github.com/bti/"
SRC_URI="mirror://kernel/software/web/bti/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND="net-misc/curl
	dev-libs/libxml2
	dev-libs/libpcre
	net-libs/liboauth"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

# Readline is dynamically loaded, for whatever reason, and can use
# libedit as an alternative...
RDEPEND="${RDEPEND}
	|| ( sys-libs/readline dev-libs/libedit )"

src_configure() {
	econf \
		--disable-dependency-tracking
}

src_install() {
	emake DESTDIR="${D}" install || die "bti could not be installed"
	dodoc bti.example README RELEASE-NOTES ||
		die "bti documentation could not be installed"
	dobashcompletion bti-bashcompletion
}
