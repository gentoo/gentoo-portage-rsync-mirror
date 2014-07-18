# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/mtr/mtr-0.85_p20140126.ebuild,v 1.9 2014/07/18 14:31:29 klausman Exp $

EAPI=5
inherit eutils flag-o-matic

DESCRIPTION="My TraceRoute, an Excellent network diagnostic tool"
HOMEPAGE="http://www.bitwizard.nl/mtr/"
SRC_URI="http://dev.gentoo.org/~jer/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="gtk ipv6 suid"

RDEPEND="
	sys-libs/ncurses
	gtk? (
		dev-libs/glib:2
		x11-libs/gtk+:2
	)"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS FORMATS NEWS README SECURITY TODO )

src_configure() {
	# In the source's configure script -lresolv is commented out. Apparently it
	# is needed for 64bit macos still.
	[[ ${CHOST} == *-darwin* ]] && append-libs -lresolv

	econf \
		--disable-gtktest \
		$(use_enable ipv6) \
		$(use_with gtk)
}

src_install() {
	default

	if use !prefix ; then
		fowners root:0 /usr/sbin/mtr
		if use suid; then
			fperms 4711 /usr/sbin/mtr
		else
			fperms 0710 /usr/sbin/mtr
		fi
	fi
}
