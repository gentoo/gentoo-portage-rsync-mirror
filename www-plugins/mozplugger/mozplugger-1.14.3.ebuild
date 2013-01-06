# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/mozplugger/mozplugger-1.14.3.ebuild,v 1.1 2011/10/03 23:30:34 robbat2 Exp $

EAPI=2
inherit eutils multilib toolchain-funcs

DESCRIPTION="Configurable browser plugin to launch streaming media players."
SRC_URI="http://mozplugger.mozdev.org/files/${P}.tar.gz"
HOMEPAGE="http://mozplugger.mozdev.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="xembed"

RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.14.3-Makefile.in.patch"
	sed -i "s:libprefix=.*:libprefix=/$(get_libdir):" Makefile.in
}

src_configure() {
	local myconf
	if [[ -x ${ECONF_SOURCE:-.}/configure ]] ; then
		if use xembed; then
			myconf="${myconf} --enable-always-xembed"
		fi

		econf \
			${myconf}
	fi
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		LD="$(tc-getCC)" \
		RPM_OPT_FLAGS="${CFLAGS}" \
		XCFLAGS="-fPIC -Wall" \
		COMMON_LDFLAGS="${LDFLAGS}" \
		all || die
}

src_install() {
	emake root="${D}" install || die
	dodoc ChangeLog README
}
