# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/miniupnpc/miniupnpc-1.9.20150424.ebuild,v 1.1 2015/04/28 17:25:56 maksbotan Exp $

EAPI=5

inherit eutils multilib toolchain-funcs

DESCRIPTION="UPnP client library and a simple UPnP client"
HOMEPAGE="http://miniupnp.free.fr/"
#SRC_URI="http://miniupnp.free.fr/files/${P}.tar.gz"
# https://github.com/miniupnp/miniupnp/issues/111
MY_COMMIT="e501f5625dd171d0133fadd31ba1d3ce7cb5424f"
SRC_URI="https://github.com/miniupnp/miniupnp/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0/12"
KEYWORDS="~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="ipv6 kernel_linux static-libs"

RDEPEND=""
DEPEND="kernel_linux? ( sys-apps/lsb-release sys-apps/which )"

S="${WORKDIR}/miniupnp-${MY_COMMIT}/${PN}"

src_prepare() {
	epatch_user

	if ! use static-libs; then
		sed -i \
			-e '/FILESTOINSTALL =/s/ $(LIBRARY)//' \
			-e '/$(INSTALL) -m 644 $(LIBRARY) $(INSTALLDIRLIB)/d' \
			Makefile || die
	fi
}

# Upstream cmake causes more trouble than it fixes,
# so we'll just stay with the Makefile for now.

src_compile() {
	tc-export CC AR
	emake upnpc-shared $(use static-libs && echo upnpc-static)
}

src_test() {
	emake -j1 HAVE_IPV6=$(usex ipv6 yes no) check
}

src_install() {
	emake \
		PREFIX="${D}" \
		INSTALLDIRLIB="${D}usr/$(get_libdir)" \
		install

	dodoc README Changelog.txt
}
